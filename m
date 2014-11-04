From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH] clk: Add PWM clock driver
Date: Tue, 04 Nov 2014 12:55:52 +0100
Message-ID: <1415102152.3701.13.camel@pengutronix.de>
References: <5410AEFD.5030302@elproma.com.pl> <20140923085130.GO30514@ulmo>
	 <20140927200122.19023.40310@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140927200122.19023.40310@quantum>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Janusz =?UTF-8?Q?U=C5=BCycki?= <j.uzycki@elproma.com.pl>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Am Samstag, den 27.09.2014, 13:01 -0700 schrieb Mike Turquette:
> Quoting Thierry Reding (2014-09-23 01:51:31)
> > On Wed, Sep 10, 2014 at 10:05:17PM +0200, Janusz U=C5=BCycki wrote:
> > > Hi,
> > >=20
> > > http://patchwork.ozlabs.org/patch/359069/
> > > https://lkml.org/lkml/2014/6/12/186
> > >=20
> > > Will the patch ever included to linux-next?
> >=20
> > I've never seen this patch before. From a quick look it doesn't see=
m
> > like it would work as is, but the idea is certainly interesting. If
> > somebody decides to continue work on it, please Cc me and the linux=
-pwm
> > mailing list.
>=20
> I just merged a gpio-controlled clock gate and I'm fine with a PWM cl=
ock
> output.
>=20
> Janusz, how are you testing the clock driver?

On the BoundaryDevices Nitrogen6X board, the master clock to the OV5640
MIPI CSI-2 sensor module has to be provided by a PWM.

regards
Philipp
