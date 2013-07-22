Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
Subject: RE: [PATCH 2/3] gpio: add LP3943 I2C GPIO expander driver
Date: Mon, 22 Jul 2013 01:19:25 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F82E83189@DQHE06.ent.ti.com>
References: <A874F61F95741C4A9BA573A70FE3998F82E815CE@DQHE06.ent.ti.com>
 <CACRpkdYVCrz_30HsX_4C5aFR0c3K4OzTXSo7gx_W39Ukpg8cpw@mail.gmail.com>
In-Reply-To: <CACRpkdYVCrz_30HsX_4C5aFR0c3K4OzTXSo7gx_W39Ukpg8cpw@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-pwm.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "grant.likely@linaro.org" <grant.likely@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>

Hi Linus,
Thanks for both of GPIO patch reviews.
I'll fix them.

> I forgot one thing:
>=20
> On Tue, Jul 16, 2013 at 4:38 AM, Kim, Milo <Milo.Kim@ti.com> wrote:
>=20
> > +static int lp3943_gpio_probe(struct platform_device *pdev)
> > +{
> > +       struct lp3943 *l =3D dev_get_drvdata(pdev->dev.parent);
> > +       struct lp3943_gpio *lg;
> > +       int ret;
>=20
> This is where I want you to assign to a member of struct
> lp3943 another u16 mask which tells which lines are
> actually available for GPIO, and you should also add code to
> make sure that lines that are not available fail gpio_request().
>=20
> This configuration can probably be read out from the device
> tree if you add the compatible node to the MFD cell when
> registering it.
>=20
> Yours,
> Linus Walleij

Regards,
Milo
