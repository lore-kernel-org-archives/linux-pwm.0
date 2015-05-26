From: Lee Jones <lee.jones@linaro.org>
Subject: [NEXT REQUEST][PATCH] backlight: pwm: handle EPROBE_DEFER while
 requesting the PWM
Date: Tue, 26 May 2015 08:36:48 +0100
Message-ID: <20150526073648.GB11677@x1>
References: <1424338214-24236-1-git-send-email-nicolas.ferre@atmel.com>
 <20150312090224.GC3314@x1>
 <20150525112718.5f7e2d7d@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150525112718.5f7e2d7d@bbrezillon>
Sender: linux-next-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>, sfr@canb.auug.org.au, linux-next@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, thierry.reding@gmail.com, jg1.han@samsung.com, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-pwm@vger.kernel.org

Stephen, Boris,

> > > When trying to request the PWM device with devm_pwm_get(), the EP=
ROBE_DEFER
> > > flag is not handled properly. It can lead to the PWM not being fo=
und.
> > >=20
> > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.co=
m>
> > > Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > > ---
> > >  drivers/video/backlight/pwm_bl.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> >=20
> > Applied, thanks.
>=20
> I don't see this patch in Linus' tree (actually, it's not even in
> linux-next).
> I don't know where it's stuck, but could you make sure it reaches
> mainline for 4.2 (or 4.1 if it's not to late) ?

Sorry for the confusion.

It looks like my for-backlight-fixes branch isn't in -next.

Stephen, could you rectify that please?

M: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
