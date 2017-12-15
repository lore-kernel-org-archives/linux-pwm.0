From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: pwm: rcar: Document r8a774[35] PWM
 bindings
Date: Fri, 15 Dec 2017 17:30:16 -0600
Message-ID: <20171215233016.s6bych6qlg7baquu@rob-hp-laptop>
References: <1513248976-26700-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1513248976-26700-3-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1513248976-26700-3-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Thu, Dec 14, 2017 at 10:56:12AM +0000, Fabrizio Castro wrote:
> This patch adds compatible strings specific to r8a774[35], no driver
> change is needed as the fallback compatible string will activate the
> right code. Also, this patch replaces the example with a DT snippet used
> for adding PWM0 support to an r8a7743 based platform.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
> Dear All,
> 
> the reason for replacing the example with one of a different SoC is that
> the new example refers to recent code from a real use case. I hope that's ok.
> 
> Thanks,
> Fabrizio
> 
>  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
