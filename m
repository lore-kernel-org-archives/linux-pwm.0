From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
Date: Sat, 4 Jul 2020 14:23:09 +0300
Message-ID: <CAHp75Vdii+w4nNErG_z_YHwsTYWR9PeJsKk53szk4p-rop-Htw@mail.gmail.com>
References: <20200503105453.23658-1-miquel.raynal@bootlin.com> <20200703145313.vwjsh5crdqx2u76a@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgGDLX1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 4 Jul 2020 07:23:27 -0400
In-Reply-To: <20200703145313.vwjsh5crdqx2u76a@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-pwm@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Jul 3, 2020 at 5:53 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Sun, May 03, 2020 at 12:54:53PM +0200, Miquel Raynal wrote:

...

> > +     ret =3D regmap_read(pca_chip->regmap, reg, &val);
> > +     mutex_unlock(&pca_chip->i2c_lock);
> > +     if (ret < 0) {
> > +             dev_err(dev, "Cannot retrieve PWM intensity (%d)\n", ret)=
;
>
> Please use %pe for error codes.

%pe is mainly for error pointers, with plain integers it will look
awkward a bit.

> > +             return 0;
> > +     }

--=20
With Best Regards,
Andy Shevchenko
