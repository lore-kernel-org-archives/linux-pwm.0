From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 2/7] drm: atmel-hlcdc: avoid initializing cfg with zero
Date: Thu, 28 Feb 2019 22:41:21 +0100
Message-ID: <20190228214121.GD30188@ravnborg.org>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
 <1551284609-14594-3-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1551284609-14594-3-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, bbrezillon@kernel.org, airlied@linux.ie, daniel@ffwll.ch, thierry.reding@gmail.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Feb 27, 2019 at 04:24:21PM +0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Remove cfg initialization with zero and read state with
> drm_crtc_state_to_atmel_hlcdc_crtc_state() so that cfg to be initialized
> with state's output_mode.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Looks good, good to have simpler code.
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
