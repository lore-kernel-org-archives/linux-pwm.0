From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: sun4i: Fix inconsistent IS_ERR and PTR_ERR
Date: Thu, 9 Jan 2020 14:18:25 +0100
Message-ID: <20200109131825.beaspmfaxh4gpcx5@pengutronix.de>
References: <20200109072735.GA22886@embeddedor>
 <20200109074445.73n3vapjl4vfjtsu@pengutronix.de>
 <CAJiuCcdFiXVtECtVGz3N9oUM38ca=MDmdK4+T+peUKKzNr_5KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJiuCcdFiXVtECtVGz3N9oUM38ca=MDmdK4+T+peUKKzNr_5KQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@siol.net>, Linux PWM List <linux-pwm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

Hello,

On Thu, Jan 09, 2020 at 10:14:00AM +0100, Clément Péron wrote:
> On Thu, 9 Jan 2020 at 08:44, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> > Hello Gustavo,
> >
> > On Thu, Jan 09, 2020 at 01:27:35AM -0600, Gustavo A. R. Silva wrote:
> > > Fix inconsistent IS_ERR and PTR_ERR in sun4i_pwm_probe().
> > >
> > > The proper pointers to be passed as arguments are pwm->clk and pwm->bus_clk.
> 
> Thanks for the catch.
> 
> As these patches are still in next should we update them or apply a fix ?

That's for Thierry to answer.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
