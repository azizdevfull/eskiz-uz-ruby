![banner](https://i.postimg.cc/zfkFXrK2/Azizdev-1-2.png "banner")

<div align="center">
<h1>Интеграция системы Eskiz отправить sms в Ruby</h1>
</div>

Этот репозиторий содержит готовые коды того, как можно отправлять СМС операторам мобильной связи. 

Эти коды содержат интеграции следующих сервисов:
- Eskiz - Успей забронировать свое место в Интернете. [Официальный сайт](https://eskiz.uz/)

## Установка
Клонируйте проект с github
```console
git clone https://github.com/azizdevfull/eskiz-uz-ruby.git
```

Установите все пакеты, необходимые для работы sms-сервисов
```bash
bundle install
```

## Интеграция [Eskiz.uz](https://eskiz.uz/)

Чтобы начать интеграцию через службу Eskiz, вам понадобятся `ESKIZ_EMAIL` и `ESKIZ_PASSWORD`. Вы можете получить эту информацию, после заключения [контракта с компанией](https://eskiz.uz/reseller)

После того, как вы получили необходимые ключи, вы должны записать их, создав файл `.env` или просто скопируйте готовый шаблон `env.example`
```console
cp env.example .env
```

Заполните `ESKIZ_EMAIL` и `ESKIZ_PASSWORD`

Перейдите к файлу `eskiz.rb` и введите свой номер телефона в переменную `phone`

### Приступаем к отправке первого СМС
```console
ruby eskiz.rb
```

Для получения дополнительной информации перейдите по [этой ссылке](https://documenter.getpostman.com/view/663428/RzfmES4z?version=latest)

### Полезные ссылки

- Официальный сайт - https://eskiz.uz
- Персоналный кабинет - https://my.eskiz.uz/dashboard
- Проверит баланс - https://my.eskiz.uz/sms
- Руководство разработчика - https://documenter.getpostman.com/view/663428/RzfmES4z?version=latest


## Автор
[Isroilov Azizbek](https://t.me/isroilov_azizbek)

## Социальные сети
<div align="center">
  Подпишитесь на нас, чтобы получать больше новостей о веб-программировании: <br>
  <a href="https://www.instagram.com/_az1z_0ken._">Instagram</a>
  <span> | </span>
  <a href="https://t.me/isroilov_azizbek">Telegram</a>
</div>