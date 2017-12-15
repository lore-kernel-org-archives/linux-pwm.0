From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/6] dt-bindings: pwm: renesas-tpu: Document r8a774[35]
 support
Date: Fri, 15 Dec 2017 14:13:56 -0600
Message-ID: <20171215201356.qitvuiuuir6fon2l@rob-hp-laptop>
References: <1513248976-26700-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1513248976-26700-5-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1513248976-26700-5-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Dec 14, 2017 at 10:56:14AM +0000, Fabrizio Castro wrote:
> Document r8a774[35] specific compatible strings. No driver change is
> needed as the fallback compatible string "renesas,tpu" activates the
> right code in the driver.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
