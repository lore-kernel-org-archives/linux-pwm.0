From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: pwm: renesas-tpu: Correct example TPU
 register block size
Date: Wed, 20 Dec 2017 15:19:05 -0600
Message-ID: <20171220211905.sfmnofkbz54zyumb@rob-hp-laptop>
References: <1513699327-27357-1-git-send-email-geert+renesas@glider.be>
 <1513699327-27357-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1513699327-27357-3-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Dec 19, 2017 at 05:02:06PM +0100, Geert Uytterhoeven wrote:
> The Timer Pulse Unit on R-Mobile A1 has registers that lie outside the
> declared register block.  Enlarge the register block size to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
