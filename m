From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [resend PATCH 1/3] pwm: mediatek: drop flag 'has_clks'
Date: Fri, 16 Nov 2018 07:47:48 +0100
Message-ID: <20181116064748.6c7shn3am4wejrnj@pengutronix.de>
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
 <20181114124752.GI2620@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181114124752.GI2620@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, Weijie Gao <weijie.gao@mediatek.com>, Roy Luo <cheng-hao.luo@mediatek.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, Nov 14, 2018 at 01:47:52PM +0100, Thierry Reding wrote:
> On Tue, Nov 13, 2018 at 10:08:22AM +0800, Ryder Lee wrote:
> > The flag 'has_clks' and related checks are superfluous as the CCF
> > subsystem does this for you.
> 
> Both of these mechanisms aren't equivalent. While CCF can deal with
> optional clocks, what the has_clks flag actually means is that the
> device doesn't need a clock (or doesn't have a clock input) on the
> devices where it is cleared.
> 
> So I'd actually be in favor of keeping the has_clks property because it
> serves as an additional sanity check. For example if you run this driver
> on an SoC that "has clocks" but if you don't list them in DT, then after
> this patch the driver will happily continue without clocks, even though
> it may break completely without those clocks. I've seen SoCs respond to
> disabled clocks for a hardware block in different ways, in many cases an
> access to any of the registers will completely hang the CPU. In other
> cases it may just crash in some other way or give you some sort of
> machine exception. None of those are good, and make the tiny bit of
> additional code required to support the has_clks flag very attractive.
> 
> But that's just my opinion. If you prefer to throw away that safety
> barrier, be my guest. But if you do, please move this functionality into
> the clock framework first and then make the driver use it.

The usual policy is: If the things specified in the dt are
wrong or incomplete, it's ok to fail however you like. So from a
correctness POV I think the change is fine.

I don't know about the mips details that John pointed out in a followup
to this mail though.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
