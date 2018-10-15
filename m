From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: tiecap: Add TI AM654 SoC specific
 compatible
Date: Mon, 15 Oct 2018 14:12:51 -0500
Message-ID: <20181015191251.GA8949@bogus>
References: <20181003170658.3835-1-vigneshr@ti.com>
 <20181003170658.3835-2-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181003170658.3835-2-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vignesh R <vigneshr@ti.com>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

On Wed, 3 Oct 2018 22:36:57 +0530, Vignesh R wrote:
> Add a new compatible string "ti,am654-ecap" to support PWM ECAP IP of
> TI AM654 SoC.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
