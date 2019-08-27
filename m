From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 07/13] dt-bindings: pwm: add a property "num-pwms"
Date: Tue, 27 Aug 2019 13:39:24 -0500
Message-ID: <20190827183924.GA24178@bogus>
References: <1566457123-20791-1-git-send-email-sam.shih@mediatek.com>
 <1566457123-20791-8-git-send-email-sam.shih@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1566457123-20791-8-git-send-email-sam.shih@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Shih <sam.shih@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Aug 22, 2019 at 02:58:37PM +0800, Sam Shih wrote:
> From: Ryder Lee <ryder.lee@mediatek.com>

The subject should indicate this is for Mediatek.

> 
> This adds a property "num-pwms" in example so that we could
> specify the number of PWM channels via device tree.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Changes since v5:
> - Add an Acked-by tag
> - This file is original v4 patch 5/10
> (https://patchwork.kernel.org/patch/11102577/)
> 
> Change-Id: I429048afeffa96f3f14533910efe242f88776043
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> index 991728cb46cb..ea95b490a913 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> @@ -14,12 +14,12 @@ Required properties:
>                  has no clocks
>     - "top": the top clock generator
>     - "main": clock used by the PWM core
> -   - "pwm1-8": the eight per PWM clocks for mt2712
> -   - "pwm1-6": the six per PWM clocks for mt7622
> -   - "pwm1-5": the five per PWM clocks for mt7623
> +   - "pwm1-N": the PWM clocks for each channel
> +   where N starting from 1 to the maximum number of PWM channels

Once converted to schema, you are going to be back to listing them out.

>   - pinctrl-names: Must contain a "default" entry.
>   - pinctrl-0: One property must exist for each entry in pinctrl-names.
>     See pinctrl/pinctrl-bindings.txt for details of the property values.
> + - num-pwms: the number of PWM channels.

You can't add new required properties without breaking compatibility. 

You already have to imply the number of channels from the compatible (or 
number of clocks) and you have to keep doing so to maintain 
compatibility, so why not just keep doing that for new chips?

Rob
