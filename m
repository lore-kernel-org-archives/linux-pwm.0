From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 2/2] pwm: sprd: Add Spreadtrum PWM support
Date: Mon, 12 Aug 2019 17:50:45 +0800
Message-ID: <CAMz4kuKDcFxbNPqS-MToiCGQCXKDSvFX75ML+iVJGZx6kL0gzA@mail.gmail.com>
References: <6a38a3655bc8100764d85cb04dea5c2546a311e1.1565168564.git.baolin.wang@linaro.org>
 <40127356a1acd1f2ff1be1d8a120b305a4e17af4.1565168564.git.baolin.wang@linaro.org>
 <20190809091013.vguj4wty7qiab64t@pengutronix.de> <CAMz4kuLQsrBWjta1s=ZRPgxUd0_+_f-GbJV138tccuMLg2XCLA@mail.gmail.com>
 <20190809144124.3as3rtctlywxkudr@pengutronix.de> <CAMz4ku+o6dCyxhR3-5yM+zr2nBpTQG5A8Pbnxpo7yRciwPbv3Q@mail.gmail.com>
 <20190812083556.dvprpwv6mjy3cjae@pengutronix.de> <CAMz4kuJA81ZP6Kc63dPV1jEn1ah=jow6tQBfO=UDCcTzSf3y-A@mail.gmail.com>
 <20190812094607.yg7efmvefewxicke@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190812094607.yg7efmvefewxicke@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On Mon, 12 Aug 2019 at 17:46, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Baolin,
>
> On Mon, Aug 12, 2019 at 05:11:56PM +0800, Baolin Wang wrote:
> > On Mon, 12 Aug 2019 at 16:36, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Mon, Aug 12, 2019 at 03:29:07PM +0800, Baolin Wang wrote:
> > > > The clock framework supplies 'assigned-clocks' and
> > > > 'assigned-clock-parents' properties to set parent, but for our case=
 we
> > > > still want to set a default clock rate if failed to set parent when
> > > > met some abnormal things.
> > >
> > > Without understanding the complete problem I'd say this is out of the
> > > area the driver should care about.
> >
> > Fair enough, I will try to use 'assigned-clocks' and
> > 'assigned-clock-parents' to simplify the code.
>
> There is also assigned-clock-rates if you need that.

Thanks for reminding, but we have no use case to set clock rate in PWM driv=
er.

--=20
Baolin Wang
Best Regards
