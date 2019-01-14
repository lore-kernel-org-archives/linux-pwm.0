From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 5/5] dt-bindings: pwm: update bindings for MT7629 SoC
Date: Mon, 14 Jan 2019 12:19:39 +0100
Message-ID: <96a54b06-8d1a-a19f-6b56-6e6224da846a@gmail.com>
References: <0c400cb1899c1afb4c9f021350cdc0c6ca3f6239.1547453586.git.ryder.lee@mediatek.com>
 <d586ce5da1774e2b87af980990f9ac649529dfcf.1547453586.git.ryder.lee@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d586ce5da1774e2b87af980990f9ac649529dfcf.1547453586.git.ryder.lee@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ryder Lee <ryder.lee@mediatek.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Sean Wang <sean.wang@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org



On 14/01/2019 09:21, Ryder Lee wrote:
> This updates bindings for MT7629 pwm controller.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> index f9e2d1f..f7e7784 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> @@ -6,6 +6,7 @@ Required properties:
>     - "mediatek,mt7622-pwm": found on mt7622 SoC.
>     - "mediatek,mt7623-pwm": found on mt7623 SoC.
>     - "mediatek,mt7628-pwm": found on mt7628 SoC.
> +   - "mediatek,mt7629-pwm", "mediatek,mt7622-pwm": found on mt7629 SoC.
>   - reg: physical base address and length of the controller's registers.
>   - #pwm-cells: must be 2. See pwm.txt in this directory for a description of
>     the cell format.
> 
