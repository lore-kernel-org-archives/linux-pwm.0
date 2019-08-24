From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v5 03/13] pwm: mediatek: add a property "clock-frequency"
Date: Sat, 24 Aug 2019 02:32:29 +0200
Message-ID: <20190824003229.7uch4m54vrxlt7uj@pengutronix.de>
References: <1566457123-20791-1-git-send-email-sam.shih@mediatek.com>
 <1566457123-20791-4-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1566457123-20791-4-git-send-email-sam.shih@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Shih <sam.shih@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello Sam,

On Thu, Aug 22, 2019 at 02:58:33PM +0800, Sam Shih wrote:
> This fix mt7628 pwm during configure from userspace. The SoC
> is legacy MIPS and has no complex clock tree. This patch add property
> clock-frequency to the SoC specific data and legacy MIPS SoC need to
> configure it in DT. This property is use for period calculation.
> 
> We will improve this fix by droping has-clks attribute and using
> clock-frequency to do the same thing in a new patch.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>

I wonder if instead the platform could provide some dummy and optional
clocks.

You could add a fixed-clock for the clk that is used to determine the
clock rate and switch to devm_clk_get_optional for the others.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
