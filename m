From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RESEND][PATCH v3 0/6] add LCD support for SAM9X60
Date: Tue, 4 Jun 2019 23:54:24 +0200
Message-ID: <20190604215424.GA1959@ravnborg.org>
References: <1556195748-11106-1-git-send-email-claudiu.beznea@microchip.com>
 <20190507182713.GA16862@ravnborg.org>
 <c361b013-2d98-76e3-d30f-cec83000933c@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c361b013-2d98-76e3-d30f-cec83000933c@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: thierry.reding@gmail.com, linux-pwm@vger.kernel.org, alexandre.belloni@bootlin.com, bbrezillon@kernel.org, airlied@linux.ie, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com, daniel@ffwll.ch, lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

Hi Claudiu.

On Tue, Jun 04, 2019 at 04:18:33PM +0000, Claudiu.Beznea@microchip.com wrote:
> Hi Sam,
> 
> On 07.05.2019 21:27, Sam Ravnborg wrote:
> > External E-Mail
> > 
> > 
> > Hi Thierry.
> > 
> >>   pwm: atmel-hlcdc: add compatible for SAM9X60 HLCDC's PWM
> > OK to add the "pwm: atmel-hlcdc: add compatible for SAM9X60 HLCDC's PWM"
> > patch via drm-misc?
> > Then we can add all 6 patches in one go.
> 
> Since we don't have an answer from Thierry till now, do you think it could
> be feasible to take the rest of the patches in this series? After that I
> will re-send the PWM patch to PWM list.

Thanks for the reminder.

Patches 1,2 and 4,5,6 applied to drm-misc-next.

Reworded changelog a bit in patch 6.

	Sam
