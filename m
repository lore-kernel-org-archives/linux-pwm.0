From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: pwm: add a property "mediatek,num-pwms"
Date: Mon, 14 Jan 2019 12:19:16 +0100
Message-ID: <1ad9afa2-0306-8a60-eb25-92f8ce100d20@gmail.com>
References: <0c400cb1899c1afb4c9f021350cdc0c6ca3f6239.1547453586.git.ryder.lee@mediatek.com>
 <37e5b296c6e854b918049a548e7c79f26b0e8147.1547453586.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <37e5b296c6e854b918049a548e7c79f26b0e8147.1547453586.git.ryder.lee@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ryder Lee <ryder.lee@mediatek.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Sean Wang <sean.wang@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org



On 14/01/2019 09:21, Ryder Lee wrote:
> This adds a property "mediatek,num-pwms" in example so that we could
> set the number of PWM channels via device tree.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> index 991728c..f9e2d1f 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> @@ -20,6 +20,7 @@ Required properties:
>   - pinctrl-names: Must contain a "default" entry.
>   - pinctrl-0: One property must exist for each entry in pinctrl-names.
>     See pinctrl/pinctrl-bindings.txt for details of the property values.
> + - mediatek,num-pwms: the number of PWM channels.
>  
>  Example:
>  	pwm0: pwm@11006000 {
> @@ -37,4 +38,5 @@ Example:
>  			      "pwm3", "pwm4", "pwm5";
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pwm0_pins>;
> +		mediatek,num-pwms = <5>;
>  	};
> 
