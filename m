From: Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: Re: [PATCH v5 08/13] dt-bindings: pwm: update bindings for MT7628
 SoC
Date: Thu, 22 Aug 2019 16:12:20 +0800
Message-ID: <1566461540.16302.4.camel@mtksdaap41>
References: <1566457123-20791-1-git-send-email-sam.shih@mediatek.com>
         <1566457123-20791-9-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1566457123-20791-9-git-send-email-sam.shih@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Shih <sam.shih@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, John Crispin <john@phrozen.org>
List-Id: linux-pwm@vger.kernel.org

On Thu, 2019-08-22 at 14:58 +0800, Sam Shih wrote:
> This updates bindings for MT7628 pwm controller.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> index ea95b490a913..93980e3da261 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> @@ -21,6 +21,10 @@ Required properties:
>     See pinctrl/pinctrl-bindings.txt for details of the property values.
>   - num-pwms: the number of PWM channels.
> +
> + Optional properties:
> + - clock-frequency: fix clock frequency, this is only used in MT7628 SoC
> +                    for period calculation. This SoC has no complex clock tree.

I'm sorry if this has been discussed before. 

Would it be simpler if you just provide a fixed-clock as clock in device
tree? This way you don't need this optional properties and don't need to
special handle it in driver code. 

After all, the hw is still connected to a simple clock tree.

Joe.C
