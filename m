From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/4] dt-bindings: pwm: mxs-pwm: Increase #pwm-cells
Date: Wed, 02 Oct 2019 09:19:13 -0500
Message-ID: <5d94b1e4.1c69fb81.63a32.683c@mx.google.com>
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk> <20190923081348.6843-5-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190923081348.6843-5-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Thierry Reding <thierry.reding@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Mon, 23 Sep 2019 10:13:48 +0200, Rasmus Villemoes wrote:
> We need to increase the pwm-cells for the optional flags parameter, in
> order to implement support for polarity setting via DT.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  Documentation/devicetree/bindings/pwm/mxs-pwm.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
