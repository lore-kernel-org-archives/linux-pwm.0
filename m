From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/5] arm64: dts: mt7622: add a property
 "mediatek,num-pwms" for PWM
Date: Tue, 15 Jan 2019 21:02:31 +0100
Message-ID: <20190115200231.drn2rbxu4jxr22yz@pengutronix.de>
References: <0c400cb1899c1afb4c9f021350cdc0c6ca3f6239.1547453586.git.ryder.lee@mediatek.com>
 <b5ed4626a553acb5e3107c6c96e82b674439128f.1547453586.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b5ed4626a553acb5e3107c6c96e82b674439128f.1547453586.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, Sean Wang <sean.wang@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hello,

On Mon, Jan 14, 2019 at 04:21:22PM +0800, Ryder Lee wrote:
> This adds a property "mediatek,num-pwms" for PWM controller.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt7622.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> index 8fc4aa7..ab016cf 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
> @@ -436,6 +436,7 @@
>  			 <&pericfg CLK_PERI_PWM6_PD>;
>  		clock-names = "top", "main", "pwm1", "pwm2", "pwm3", "pwm4",
>  			      "pwm5", "pwm6";
> +		mediatek,num-pwms = <6>;
>  		status = "disabled";

Conceptually this patch must go in before the change to the driver.
Otherwise the pwms are not usable with only patch 1 applied which breaks
bisectability.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
