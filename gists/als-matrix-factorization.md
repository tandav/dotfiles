- [a2f87e91cb5c441c57657cceb788c86c](https://gist.github.com/tandav/a2f87e91cb5c441c57657cceb788c86c)

---

### Задача
Дана таблица рейтингов(оценок): где каждый user оценивал какой-то item например фильм (movie). Допустим рейтинг оценивается от 1.0 до 5.0 

Пример таблицы:
```
+----+-----+------+
|user|movie|rating|
+----+-----+------+
|   1|    1|   4.0|
|   1|    3|   4.0|
|   1|    6|   4.0|
|   1|   47|   5.0|
|   2|   50|   5.0|
|   3|   70|   3.0|
|   3|  101|   5.0|
+----+-----+------+
```

Эту таблицу также можно представить в виде матрицы где каждая строка это user а каждая колонка это movie
![image](https://user-images.githubusercontent.com/5549677/50385827-17edff80-06ed-11e9-9762-4a3c26a6b18f.png)

Матрица может быть разреженной (sparse), может почти полностью быть пустой. Так как каждый user смотрит только небольшое количество фильмов (относительно общего числа фильмов).

Задача состоит в том чтобы заполнить пустые ячейки в этой матрице. Узнать рейтинг каждого фильма от каждого пользователя.  
Если это сделать то можно получить фильмы которые можно рекомендовать конкретному пользователю. (это фильмы с максимальным рейтингом в его строчке, которые не были им просмотрены).

### Факторизация Матрицы
Идея алгоритма Matrix factorization (далее MF) предпологает что:
- каждый человек может быть описан с помощью k признаков. Например признак 1 может быть числом которое обозначает, насколько человеку нравится научная фантастика
- каждый фильм может быть описан аналогичным набором признаков. Для примера выше признак 1 может означать насколько близок фильм к научной фантастике.
- Если мы умножим признаки пользователя на соответсвующие признаки фильма и сложим все вместе (dot product) то это может быть хорошей аппроксимацией того, какую оценку пользователь дал фильму.

![image](https://user-images.githubusercontent.com/5549677/50385990-a499bd00-06ef-11e9-92bf-c3298888a679.png)

Обозначим  
матрица рейтингов R  
матрица пользователей U  
матрица фильмов M  

R = U x M  

чтобы найти U и M - заполним их случайными числами из диапазона рейтингов
потом будем поочередно:  
1. фиксировать U и изменять V
2. фиксировать V и изменять U

Повторять это до тех пор пока R = U x M будет выполняться с заданной точностью.  
Так как в матрице R много значений пропущенно сравинивать равенство (считать ошибку)только для тех ячеек которые присутствуют в R. 
Метрика которую мы минимизируем - это RMSE (корень суммы квадратов ошибок). Минимизировать можно через SGD (stochastic gradient descent).

Можно сделать валидацию модели, зарезервировав часть значаений в R для теста. (для модели они будут неизвестными и модель должна сделать предсказания для этих ячеек). Потом сравнить результаты.

### Пример реализации алгоритма для больших данных с использованием pyspark
Databricks предостовляет бесплатный spark кластер для учебных целей.  
Доступ к кластеру осуществляется через jupyter.  
https://community.cloud.databricks.com

#### Установка своего pyspark кластера с исползованием docker
требования: установленный docker

Запустим контейнер с установленным pyspark
```
docker run -p 8888:8888 jupyter/pyspark-notebook
```
контейнер также запускает jupyter notebook, который доступен по адресу:  
http://localhost:8888

Перейдя по адресу можно создать новый notebook, в котором будет нужно вводить весь дальнейший код.  

Скачаем свободный датасет с оценками фильмов от GroupLens:
```
!wget http://files.grouplens.org/datasets/movielens/ml-latest-small.zip
!unzip ml-latest-small.zip
```

Импортируем необходимые модули и создадим spark сессию:
```py
from pyspark.ml.evaluation import RegressionEvaluator
from pyspark.ml.recommendation import ALS
from pyspark.ml.tuning import TrainValidationSplit, ParamGridBuilder
from pyspark.sql.types import *
from pyspark.sql import SparkSession

spark = SparkSession.builder.getOrCreate()
```

Создадим DataFrame с рейтингами из скачанного датасета:
```py
schema = StructType([
    StructField('user'     , IntegerType()),
    StructField('movie'    , IntegerType()),
    StructField('rating'   , DoubleType ()),
    StructField('timestamp', LongType   ()),
])

ratings = spark.read.csv('ml-latest-small/ratings.csv', header=True, schema=schema).select(['user', 'movie', 'rating'])
# ratings = ratings.limit(500) # uncomment if you want to limit number of rows in dataset
ratings.show()
```

```
+----+-----+------+
|user|movie|rating|
+----+-----+------+
|   1|    1|   4.0|
|   1|    3|   4.0|
|   1|    6|   4.0|
|   1|   47|   5.0|
|   1|   50|   5.0|
|   1|   70|   3.0|
|   1|  101|   5.0|
|   1|  110|   4.0|
|   1|  151|   5.0|
|   1|  157|   5.0|
|   1|  163|   5.0|
|   1|  216|   5.0|
|   1|  223|   3.0|
|   1|  231|   5.0|
|   1|  235|   4.0|
|   1|  260|   5.0|
|   1|  296|   3.0|
|   1|  316|   3.0|
|   1|  333|   5.0|
|   1|  349|   4.0|
+----+-----+------+
only showing top 20 rows
```

Разделим наш датасет на 2 части: для обучения и для тестирования модели. (0.8 датасета на train, 0.2 на test)
```py
train, test = ratings.randomSplit([0.8, 0.2])
```

Создадим модель ALS например со следующими параметрами:
```py
als = ALS(
    rank              = 13      ,
    maxIter           = 20      ,
    regParam          = 0.17    , 
    userCol           = 'user'  ,
    itemCol           = 'movie' , 
    ratingCol         = 'rating', 
    coldStartStrategy = 'drop'  , 
    nonnegative       = True
)
```

Обучим модель на тренировачных и сделаем предсказания для тестовых данных
```py
als = als.fit(train)
predictions = als.transform(test)
```

Посмотрим на предсказания:
```py
predictions.show()
```

```
+----+-----+------+----------+
|user|movie|rating|prediction|
+----+-----+------+----------+
| 218|  471|   4.0| 2.8190367|
| 462|  471|   2.5| 2.9939091|
| 176|  471|   5.0| 3.4599283|
| 426|  471|   5.0| 3.4690142|
| 541|  471|   3.0| 2.9153185|
| 159| 1088|   4.0| 2.4352484|
| 606| 1088|   3.0| 3.2263904|
|  20| 1088|   4.5| 3.6164813|
| 169| 1088|   4.5| 4.0649753|
| 479| 1088|   4.0| 2.9778028|
| 554| 1088|   5.0| 3.5482545|
|  51| 1088|   4.0| 3.0569701|
|  10| 1088|   3.0| 3.0331068|
| 226| 1088|   1.0| 3.4328682|
|  68| 1088|   3.5| 3.3370109|
| 104| 1088|   3.0| 3.4865294|
| 325| 1238|   4.0|  4.129932|
| 599| 1342|   2.5| 2.3142223|
| 387| 1342|   3.0| 3.2119217|
| 307| 1342|   2.0| 3.4193916|
+----+-----+------+----------+
only showing top 20 rows
```

Посмотрим на ошибки предсказания
```py
import matplotlib.pyplot as plt
import numpy as np

rating_pred = predictions.rdd.map(lambda x: x.prediction).collect()
rating_true = predictions.rdd.map(lambda x: x.rating    ).collect()

error = np.array(rating_pred) - np.array(rating_true)
mean = error.mean()
std  = error.std() 

plt.figure(figsize=(14, 10))
plt.plot(error)
plt.axhline(mean      , color='r')
plt.axhline(mean - std, color='r')
plt.axhline(mean + std, color='r')
```
![image](https://user-images.githubusercontent.com/5549677/50415238-ff83ff00-082a-11e9-8198-1216d5e15e35.png)

Гистограммы ошибок
```py
plt.figure(figsize=(7, 5))
plt.hist(error, bins=50, label='error = rating_pred - rating_true')
plt.axvline(x=mean, color='red')
plt.legend(loc=1)
```
![image](https://user-images.githubusercontent.com/5549677/50415541-838ab680-082c-11e9-88db-86da1360cc80.png)
