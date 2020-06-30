From: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Subject: Re: [RFC PATCH 00/10] Netronix embedded controller driver for Kobo
 and Tolino ebook readers
Date: Tue, 30 Jun 2020 21:22:07 +0200
Message-ID: <20200630212207.018ad355@aktux>
References: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
        <20200630084051.66feadea@aktux>
        <20200630071523.GA2983@latitude>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200630071523.GA2983@latitude>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Pengutronix Kernel Team <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, NXP Linux Team <linux-imx-3arQi8VN3Tc@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko.stuebner-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>, Stephan Gerhold <stephan-3XONVrnlUWDR7s880joybQ@public.gmane.org>, Lubomir Rintel <lkundrak-NGH9Lh4a5iE@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, allen <allen.chen-4K37Az1KcQBeoWH0uzbU5w@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, 30 Jun 2020 09:15:23 +0200
Jonathan Neusch=C3=A4fer <j.neuschaefer-hi6Y0CQ0nG0@public.gmane.org> wrote:

> On Tue, Jun 30, 2020 at 08:40:51AM +0200, Andreas Kemnade wrote:
> [...]
> > got a chance to test it on a Tolino Shine 2 HD.
> > It uses the RTC from the RC5T619 but backlight seems to go via MSP430
> > EC.
> >=20
> > I got this.
> >=20
> > [    1.453603] ntxec 0-0043: Netronix embedded controller version f110 =
detected.
> > [   10.723638] ntxec-rtc 21a0000.i2c:embedded-controller@43:rtc: regist=
ered as rtc0
> > [   10.775276] ntxec-pwm: probe of 21a0000.i2c:embedded-controller@43:p=
wm failed with error -5 =20
>=20
> Hmm, -EIO from the PWM driver.
>
Weird...
IOMUXC_SW_PAD_CTL_PAD_I2C1_SDA/SCL is identical between
vendor kernel (heavily patched 3.0.35) and patched mainline.
                       =20
MX6SL_PAD_I2C1_SCL__I2C1_SCL     0x4001f8b1
MX6SL_PAD_I2C1_SDA__I2C1_SDA     0x4001f8b1

root@tolino2:~# i2cset -f 0 0x43 0xa3 0x0001 w
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will write to device file /dev/i2c-0, chip address 0x43, data address
0xa3, data 0x01, mode word.
Continue? [Y/n]=20
Error: Write failed
root@tolino2:~# i2cset -f 0 0x43 0xa3 0x0000 w
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will write to device file /dev/i2c-0, chip address 0x43, data address
0xa3, data 0x00, mode word.
Continue? [Y/n]=20
Error: Write failed

but backlight gets toggled. Same behavior on vendor kernel and
in vendor uboot.
That smells.

Regards,
Andreas
