From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: sprd: Add Spreadtrum PWM
 documentation
Date: Wed, 14 Aug 2019 09:01:21 +0200
Message-ID: <20190814070121.o53tj2mtky4hcy3n@pengutronix.de>
References: <f9d2c7cb01cbf31bf75c4160611fa1d37d99f355.1565703607.git.baolin.wang@linaro.org>
 <20190813141256.jnbrfld42rtigek3@pengutronix.de>
 <CAMz4kuJA+a=nzFRja4wRkfJu3Gzb0wnvaM8H4Ek9X5u8CNegPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMz4kuJA+a=nzFRja4wRkfJu3Gzb0wnvaM8H4Ek9X5u8CNegPg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pwm@vger.kernel.org, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

Hello Baolin,

On Wed, Aug 14, 2019 at 09:51:34AM +0800, Baolin Wang wrote:
> On Tue, 13 Aug 2019 at 22:13, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Tue, Aug 13, 2019 at 09:46:40PM +0800, Baolin Wang wrote:
> > > +- assigned-clock-parents: The phandle of the parent clock of PWM clock.
> >
> > I'm not sure you need to point out assigned-clocks and
> > assigned-clock-parents as this is general clk stuff. Also I wonder if
> > these should be "required properties".
> 
> I think I should describe any properties used by PWM node, like
> 'clocks' and 'clock-names' properties, though they are common clock
> properties.

Then you might want to describe also "status", "assigned-clock-rates",
"pinctrl-$n", "pinctrl-names", "power-domains", "power-domain-names" and
probably another dozen I'm not aware of.

> Yes, they are required. Thanks for your comments.

required in which sense? Why can a Spreadtrum PWM not work when the
clock parents are unspecified?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
