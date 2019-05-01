From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm: Update bindings for the Meson
 G12A Family
Date: Wed, 1 May 2019 15:01:04 -0500
Message-ID: <20190501200104.GA29281@bogus>
References: <20190423133646.5705-1-narmstrong@baylibre.com>
 <20190423133646.5705-2-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190423133646.5705-2-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: thierry.reding@gmail.com, devicetree@vger.kernel.org, baylibre-upstreaming@groups.io, Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, 23 Apr 2019 15:36:44 +0200, Neil Armstrong wrote:
> Update the doc to explicitly support Meson G12A Family.
> The 2 first (A & B) AO PWM uses different clock source than the last 2
> (C & D) AO PWM modules, thus we need to differentiate them.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-meson.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
