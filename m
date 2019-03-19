From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v10 2/2] pwm: sifive: Add a driver for SiFive SoC PWM
Date: Tue, 19 Mar 2019 09:09:50 +0100
Message-ID: <20190319080950.4nsgzvkz5iwbkb24@pengutronix.de>
References: <1552909634-18757-1-git-send-email-yash.shah@sifive.com>
 <1552909634-18757-3-git-send-email-yash.shah@sifive.com>
 <20190318214640.ob2ldr3tpn2vsfkl@pengutronix.de>
 <CAJ2_jOHqGBB=eej6KkdspTNiCU_uJ8deHN3O=BQmyu=GtrTT7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJ2_jOHqGBB=eej6KkdspTNiCU_uJ8deHN3O=BQmyu=GtrTT7w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yash Shah <yash.shah@sifive.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Sachin Ghadi <sachin.ghadi@sifive.com>, Paul Walmsley <paul.walmsley@sifive.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On Tue, Mar 19, 2019 at 12:52:12PM +0530, Yash Shah wrote:
> On Tue, Mar 19, 2019 at 3:16 AM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Mon, Mar 18, 2019 at 05:17:14PM +0530, Yash Shah wrote:
> > > +     val = PWM_SIFIVE_PWMCFG_EN_ALWAYS |
> > > +           FIELD_PREP(PWM_SIFIVE_PWMCFG_SCALE, scale);
> > > +     writel(val, pwm->regs + PWM_SIFIVE_PWMCFG);
> >
> > Starting with this write the new period length might be active with the
> > previous duty cycle. Is this worth a comment? I think the window where
> > this can actually happen should be made as small as possible, so it
> > would be great to first calculate both register values and then write
> > them in two consecutive writels.
> 
> The comment for this scenario has already been mentioned under the
> limitation on top of this driver.
> Anyway, I will try to implement your suggestion of consecutive writes

Yeah, the comment at the top is for general information about the
shortcomings. The comment here would be to say: The problem occurs *here*.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
