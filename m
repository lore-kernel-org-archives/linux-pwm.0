From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v9 03/11] pwm: mediatek: remove a property "has-clks"
Date: Wed, 25 Sep 2019 08:30:03 +0200
Message-ID: <20190925063003.aht4platmfalcqru@pengutronix.de>
References: <1568933351-8584-1-git-send-email-sam.shih@mediatek.com>
 <1568933351-8584-4-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1568933351-8584-4-git-send-email-sam.shih@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Shih <sam.shih@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Fri, Sep 20, 2019 at 06:49:03AM +0800, Sam Shih wrote:
> We can use fixed-clock to repair mt7628 pwm during configure from
> userspace. The SoC is legacy MIPS and has no complex clock tree.
> Due to we can get clock frequency for period calculation from DT
> fixed-clock, so we can remove has-clock property, and directly
> use devm_clk_get and clk_get_rate.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Acked-by: Uwe Kleine-Kö <u.kleine-koenig@pengutronix.de>
> ---
> Changes since v9:
> Added an Acked-by tag

Argh, my name was croped and ended up in this state in
5c50982af47ffe36df3e31bc9e11be5a067ddd18. Thierry, any chance to repair
that? Something
like

	git filter-branch --msg-filter 'sed "s/Kleine-Kö /Kleine-König /"' linus/master..

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
