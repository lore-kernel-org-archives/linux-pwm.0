From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH V8 2/5] pwm: Add i.MX TPM PWM driver support
Date: Thu, 21 Mar 2019 16:47:08 +0100
Message-ID: <20190321154708.riet2mzmif2b7hw6@pengutronix.de>
References: <1553128960-17923-1-git-send-email-Anson.Huang@nxp.com>
 <1553128960-17923-3-git-send-email-Anson.Huang@nxp.com>
 <20190321091950.tkzem7cbgvtynr5m@pengutronix.de>
 <DB3PR0402MB3916CE06E6EF103470915905F5420@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190321104112.xits5qgk7tsuhdps@pengutronix.de>
 <DB3PR0402MB3916094B2F7A4D878785C676F5420@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190321134212.hypmz4enz7z5wamg@pengutronix.de>
 <DB3PR0402MB39162604F6C2D57FBD56E884F5420@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39162604F6C2D57FBD56E884F5420@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Robin Gong <yibin.gong@nxp.com>, "schnitzeltony@gmail.com" <schnitzeltony@gmail.com>, "otavio@ossystems.com.br" <otavio@ossystems.com.br>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "stefan@agner.ch" <stefan@agner.ch>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Leonard Crestez <leonard.crestez@nx>
List-Id: linux-pwm@vger.kernel.org

Hello,

On Thu, Mar 21, 2019 at 02:53:06PM +0000, Anson Huang wrote:
> > Reading through the reference manual I noticed that there might be a
> > stall: If you write two values to CnV the second write is ignored if the first
> > wasn't latched yet. That might mean that you cannot release the mutex
> > before the newly configured state is active. This is related to the request to
> > not let .apply return before the configured state is active, but I didn't thought
> > this to an end what the real consequences have to be.
> 
> The reference manual says the register is NOT updated until the current period finished
> If counter is running, so I added below check for both period update and duty update, we
> Can just wait the register value read matches what we write:
> 
> Period update:
>          writel(p->mod, tpm->base + PWM_IMX_TPM_MOD);
> 
>          /* make sure MOD register is updated */
>          timeout = jiffies + msecs_to_jiffies(tpm->real_period /
>                                               NSEC_PER_MSEC + 1);
>          while (readl(tpm->base + PWM_IMX_TPM_MOD != p->mod)) {
>                  if (time_after(jiffies, timeout))
>                          return = -ETIME;
>                  cpu_relax();
>          }

Hmm, I'm not convinced. There are several things to keep in mind:

 a) you should try to update period and duty_cycle atomically, that is,
    the new values should get both active at the same time. So if the
    PWM is running and the first of the two parameters are written to
    the hardware, the second parameter must be written, too, before the
    current period ends.

 b) A write to CnV or MOD blocks further writes until the respective
    value is "updated" (which I think means "latched into the hardware's
    logic to take effect). So you need to make sure that when updating
    the parameters of a running PWM, you didn't already configure it
    since the current period started.

b) is automatically addressed if you only return from .apply() when the
new configuration is active and hold the mutex during that time.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
