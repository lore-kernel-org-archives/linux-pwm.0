From: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Subject: Re: [RFC PATCH 00/10] Netronix embedded controller driver for Kobo
 and Tolino ebook readers
Date: Tue, 30 Jun 2020 22:14:47 +0200
Message-ID: <20200630221447.3e03ae28@aktux>
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
>=20
turing debugging on:

[  330.330599] i2c i2c-0: <i2c_imx_xfer_common>
[  330.330621] i2c i2c-0: <i2c_imx_start>
[  330.332927] i2c i2c-0: <i2c_imx_bus_busy>
[  330.332953] i2c i2c-0: <i2c_imx_xfer_common> transfer message: 0
[  330.332971] i2c i2c-0: <i2c_imx_write> write slave address: addr=3D0x86
[  330.334365] i2c i2c-0: <i2c_imx_trx_complete> TRX complete
[  330.334386] i2c i2c-0: <i2c_imx_acked> ACK received
[  330.334402] i2c i2c-0: <i2c_imx_write> write data
[  330.334420] i2c i2c-0: <i2c_imx_write> write byte: B0=3D0xA3
[  330.334756] i2c i2c-0: <i2c_imx_trx_complete> TRX complete
[  330.334774] i2c i2c-0: <i2c_imx_acked> ACK received
[  330.334790] i2c i2c-0: <i2c_imx_write> write byte: B1=3D0x0
[  330.351573] i2c i2c-0: <i2c_imx_trx_complete> TRX complete
[  330.351598] i2c i2c-0: <i2c_imx_acked> No ACK
[  330.351613] i2c i2c-0: <i2c_imx_stop>
[  330.351629] i2c i2c-0: <i2c_imx_bus_busy>
[  330.351648] i2c i2c-0: <i2c_imx_xfer_common> exit with: error: -6
[  330.351690] i2c i2c-0: <i2c_imx_xfer_common>
[  330.351704] i2c i2c-0: <i2c_imx_start>
[  330.352297] i2c i2c-0: <i2c_imx_bus_busy>
[  330.352321] i2c i2c-0: <i2c_imx_xfer_common> transfer message: 0
[  330.352339] i2c i2c-0: <i2c_imx_write> write slave address: addr=3D0x86
[  330.362152] i2c i2c-0: <i2c_imx_trx_complete> TRX complete
[  330.362176] i2c i2c-0: <i2c_imx_acked> ACK received
[  330.362191] i2c i2c-0: <i2c_imx_write> write data
[  330.362208] i2c i2c-0: <i2c_imx_write> write byte: B0=3D0xA1
[  330.362442] i2c i2c-0: <i2c_imx_trx_complete> TRX complete
[  330.362461] i2c i2c-0: <i2c_imx_acked> ACK received
[  330.362479] i2c i2c-0: <i2c_imx_write> write byte: B1=3D0xFF
[  330.362686] i2c i2c-0: <i2c_imx_trx_complete> TRX complete
[  330.362705] i2c i2c-0: <i2c_imx_acked> No ACK
[  330.362720] i2c i2c-0: <i2c_imx_stop>
[  330.362735] i2c i2c-0: <i2c_imx_bus_busy>
[  330.362753] i2c i2c-0: <i2c_imx_xfer_common> exit with: error: -6
[  330.362794] i2c i2c-0: <i2c_imx_xfer_common>
[  330.362808] i2c i2c-0: <i2c_imx_start>
[  330.363071] i2c i2c-0: <i2c_imx_bus_busy>
[  330.363094] i2c i2c-0: <i2c_imx_xfer_common> transfer message: 0
[  330.363112] i2c i2c-0: <i2c_imx_write> write slave address: addr=3D0x86
[  330.363313] i2c i2c-0: <i2c_imx_trx_complete> TRX complete
[  330.363331] i2c i2c-0: <i2c_imx_acked> ACK received
[  330.363346] i2c i2c-0: <i2c_imx_write> write data
[  330.363362] i2c i2c-0: <i2c_imx_write> write byte: B0=3D0xA2
[  330.363572] i2c i2c-0: <i2c_imx_trx_complete> TRX complete
[  330.363591] i2c i2c-0: <i2c_imx_acked> ACK received
[  330.363608] i2c i2c-0: <i2c_imx_write> write byte: B1=3D0xFF
[  330.363822] i2c i2c-0: <i2c_imx_trx_complete> TRX complete
[  330.363841] i2c i2c-0: <i2c_imx_acked> No ACK
[  330.363854] i2c i2c-0: <i2c_imx_stop>
[  330.363869] i2c i2c-0: <i2c_imx_bus_busy>
[  330.363886] i2c i2c-0: <i2c_imx_xfer_common> exit with: error: -6

Regards,
Andreas
