From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4] dt-bindings: pwm: Add R-Car M3-W device tree bindings
Date: Mon, 15 May 2017 15:57:46 -0500
Message-ID: <20170515205746.ixqd4v44ek2mhjna@rob-hp-laptop>
References: <1494576582-17881-1-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1494576582-17881-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Fri, May 12, 2017 at 10:09:42AM +0200, Simon Horman wrote:
> From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> 
> Add device tree bindings for the PWM controller found on R-Car M3-W SoCs.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
> v4
> * Broke out of lager patchset on which it appears to have no dependencies
> * Added Reviewed by tags 
> ---
>  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org> 
