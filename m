From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [resend PATCH 3/3] dt-bindings: pwm: update bindings for MT7629
 SoC
Date: Tue, 13 Nov 2018 10:55:39 +0100
Message-ID: <20181113095539.frqnvdfts632k3os@pengutronix.de>
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542074855.git.ryder.lee@mediatek.com>
 <630234ce3f13d93650c820be8f1724b84dd3c0ba.1542074855.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <630234ce3f13d93650c820be8f1724b84dd3c0ba.1542074855.git.ryder.lee@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, Weijie Gao <weijie.gao@mediatek.com>, Roy Luo <cheng-hao.luo@mediatek.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Nov 13, 2018 at 10:08:24AM +0800, Ryder Lee wrote:
> This updates bindings for MT7629 pwm controller.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> index 991728c..4a2885b 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> @@ -6,6 +6,7 @@ Required properties:
>     - "mediatek,mt7622-pwm": found on mt7622 SoC.
>     - "mediatek,mt7623-pwm": found on mt7623 SoC.
>     - "mediatek,mt7628-pwm": found on mt7628 SoC.
> +   - "mediatek,mt7629-pwm": found on mt7629 SoC.
>   - reg: physical base address and length of the controller's registers.
>   - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
>     the cell format.

Does the mt7629 need clocks? I'd suggest to move the clocks and
clock-names description to a section "Optional properties" to match what
is implemented in patch 1 of this series.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
