Return-Path: <horms@verge.net.au>
Date: Mon, 24 Sep 2018 17:32:05 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] dt-bindings: pwm: renesas: tpu: fix "compatible" prop
 description
Message-ID: <20180924153204.4mym2yuz7upvp6cs@verge.net.au>
References: <2aaa98bd-475c-08dd-ee34-d41fb960952e@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aaa98bd-475c-08dd-ee34-d41fb960952e@cogentembedded.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-renesas-soc@vger.kernel.org

On Fri, Sep 21, 2018 at 11:45:24PM +0300, Sergei Shtylyov wrote:
> The "compatible" property description contradicts even the example given:
> it only says that there must be a single value while the example has the
> fallback value too -- which makes much more sense. Moreover, the generic
> property value is misdocumented as being R-Car (and RZ/G1) specific...
> 
> Fixes: 382457e562bb ("pwm: renesas-tpu: Add DT support")
> Fixes: 3ba111a01822 ("dt-bindings: pwm: renesas-tpu: Document r8a774[35] support")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> This patch is against Linus' repo -- the 'fixes' branch in Thierry Reding's
> repo is very outdated...

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
