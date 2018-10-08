Return-Path: <horms@verge.net.au>
Date: Mon, 8 Oct 2018 09:38:14 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] dt-bindings: pwm: renesas-tpu: Document r8a7744 support
Message-ID: <20181008073814.bhrpp6kk5zdgdefr@verge.net.au>
References: <1538670094-40946-1-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538670094-40946-1-git-send-email-biju.das@bp.renesas.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Biju Das <biju.das@bp.renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Fabrizio Castro <fabrizio.castro@bp.renesas.com>, linux-renesas-soc@vger.kernel.org

On Thu, Oct 04, 2018 at 05:21:34PM +0100, Biju Das wrote:
> Document r8a7744 specific compatible strings. No driver change is
> needed as the fallback compatible string "renesas,tpu" activates the
> right code in the driver.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
