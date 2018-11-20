From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: =?iso-8859-1?B?W1JDRqBQQVRDSCx2Miwy?= =?iso-8859-1?B?LzJd?= pwm:
 imx: Configure output to GPIO in disabled state
Date: Tue, 20 Nov 2018 17:54:57 +0100
Message-ID: <20181120165457.x7svxgzaae5at32x@pengutronix.de>
References: <4fbb7307-df01-d7bd-f2e2-e05e6d17807d@ysoft.com>
 <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de>
 <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de>
 <20181115152545.GA8611@ulmo>
 <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
 <20181116095124.GA28631@ulmo>
 <6e81d63b-61a1-36fe-0c24-3ff27438cbc0@ysoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6e81d63b-61a1-36fe-0c24-3ff27438cbc0@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>, Linus Walleij <linus.walleij@linaro.org>, viresh kumar <viresh.kumar@linaro.org>
List-Id: linux-pwm@vger.kernel.org

Hello Michal,

On Tue, Nov 20, 2018 at 01:14:33PM +0000, Vokáč Michal wrote:
> On 16.11.2018 10:51, Thierry Reding wrote:
> > On Thu, Nov 15, 2018 at 09:37:33PM +0100, Uwe Kleine-König wrote:
> >> On Thu, Nov 15, 2018 at 04:25:45PM +0100, Thierry Reding wrote:
> > My impression was that he was trying to find concensus. But the way I
> > read it he was still arguing that the pinctrl solution was still the
> > most complete, and would therefore still prefer it.
> 
> It is like you said Thierry. I am only trying to remain open to test
> Uwe's ideas. After what I have tested so far I still prefer a imx-specific
> pinctrl solution.

Is that because you consider it right to be imx-specific or because
that's what you already have? Is there a flaw in my explanation that
the problem isn't imx-specific per se and so the solution shouldn't be
that either?

Is the problem with the "tests so far" that it doesn't work yet, or is
there something conceptually wrong in your eyes?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
