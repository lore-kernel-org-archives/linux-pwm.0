From: <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 1/7] drm: atmel-hlcdc: add config option for clock
 selection
Date: Fri, 1 Mar 2019 10:06:36 +0000
Message-ID: <ea061402-6caa-62d0-c445-acdcdf3ab08c@microchip.com>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
 <1551284609-14594-2-git-send-email-claudiu.beznea@microchip.com>
 <20190228213858.GC30188@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190228213858.GC30188@ravnborg.org>
Content-Language: en-US
Content-ID: <C8E8A2EB2525CA45B563649AE4ABDDB1@namprd11.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: sam@ravnborg.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alexandre.belloni@bootlin.com, bbrezillon@kernel.org, airlied@linux.ie, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com, robh+dt@kernel.org, thierry.reding@gmail.com, dri-devel@lists.freedesktop.org, daniel@ffwll.ch, lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org



On 28.02.2019 23:38, Sam Ravnborg wrote:
> Hi Claudiu
> 
> One more reply to this patch...
> 
> On Wed, Feb 27, 2019 at 04:24:16PM +0000, Claudiu.Beznea@microchip.com wrote:
>> From: Claudiu Beznea <claudiu.beznea@microchip.com>
>>
>> SAM9x60 LCD Controller has no option to select clock source as previous
>> controllers have. To be able to use the same driver even for this LCD
>> controller add a config option to know if controller supports this.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 12 +++++++-----
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h   |  2 ++
>>  2 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> index 8070a558d7b1..17a7a18f6a07 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
>> @@ -78,7 +78,8 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>>  	unsigned long mode_rate;
>>  	struct videomode vm;
>>  	unsigned long prate;
>> -	unsigned int cfg;
>> +	unsigned int mask = ATMEL_HLCDC_CLKDIV_MASK | ATMEL_HLCDC_CLKPOL;
>> +	unsigned int cfg = 0;
>>  	int div;
>>  
>>  	vm.vfront_porch = adj->crtc_vsync_start - adj->crtc_vdisplay;
>> @@ -101,7 +102,10 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>>  		     (adj->crtc_hdisplay - 1) |
>>  		     ((adj->crtc_vdisplay - 1) << 16));
>>  
>> -	cfg = ATMEL_HLCDC_CLKSEL;
>> +	if (!crtc->dc->desc->fixed_clksrc) {
>> +		cfg = ATMEL_HLCDC_CLKSEL;
>> +		mask |= ATMEL_HLCDC_CLKSEL;
>> +	}
> Maybe this is just too late to look at code, but I do not get this.
> If the sam9x60 do not support selecting the clk rate then I assume it is either
> fixed to used system clock or 2 x system clock.

SAM9X60's LCD controller has no support for selecting clock source (and for
the moment, yes, as Alexandre specified, the datasheet is not public). If
you look at e.g. SAM9X35 datasheet , chapter 45.7, at LCD Controller
Configuration Register 0 [1], you will see this CLKSEL bit. On SAM9X60 you
don't have this option, but you have only one clock source, fixed one. You
still have the option to divide this clock to get LCD pixel clock using
CLKDIV field of LCD Controller Configuration Register 0, and the formula is
the same as in SAM9X35 case: the only difference is that the formula uses
the fixed clock in case of SAM9X60 apart from SAM9X35 which uses the
selected clock:
SAM9X60: LCDPCLK = source clock / (CLKDIV+2)
SAM9X35: pixel_clock = selected_clock / (CLKDIV + 2).

[1]
http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11055-32-bit-ARM926EJ-S-Microcontroller-SAM9X35_Datasheet.pdf#G38.1471048

> 
> And we have in the driver code to adjust the "div" value.
> The value of div depends on the CLKSEL configuration, so there must
> be one part of this that is not valid when fixed_clksrc is true.

When fixed_clksrc is true you still have to option to divide the source clock.

I hope I was clear.

> 
>>  
>>  	prate = 2 * clk_get_rate(crtc->dc->hlcdc->sys_clk);
>>  	mode_rate = adj->crtc_clock * 1000;
>> @@ -132,9 +136,7 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>>  
>>  	cfg |= ATMEL_HLCDC_CLKDIV(div);
> 
> It is the following code (not visible in this patch I talk about:
>        if (div < 2) {
>                 div = 2;
>         } else if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK) {
>                 /* The divider ended up too big, try a lower base rate. */
>                 cfg &= ~ATMEL_HLCDC_CLKSEL;
>                 prate /= 2;
>                 div = DIV_ROUND_UP(prate, mode_rate);
>                 if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK)
>                         div = ATMEL_HLCDC_CLKDIV_MASK;
>         } else {
>                 int div_low = prate / mode_rate;
> 
>                 if (div_low >= 2 &&
>                     ((prate / div_low - mode_rate) <
>                      10 * (mode_rate - prate / div)))
>                         /*
>                          * At least 10 times better when using a higher
>                          * frequency than requested, instead of a lower.
>                          * So, go with that.
>                          */
>                         div = div_low;
>         }
> 
> Am I missing something obvious?
> 
>> -	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(0),
>> -			   ATMEL_HLCDC_CLKSEL | ATMEL_HLCDC_CLKDIV_MASK |
>> -			   ATMEL_HLCDC_CLKPOL, cfg);
>> +	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(0), mask, cfg);
>>  
>>  	cfg = 0;
>>  
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
>> index 70bd540d644e..0155efb9c443 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
>> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h
>> @@ -328,6 +328,7 @@ atmel_hlcdc_layer_to_plane(struct atmel_hlcdc_layer *layer)
>>   * @max_hpw: maximum horizontal back/front porch width
>>   * @conflicting_output_formats: true if RGBXXX output formats conflict with
>>   *				each other.
>> + * @fixed_clksrc: true if clock source is fixed
> Be specific here. Tell if "fixed_clksrc == true" equals system clock or 2 x system clock.

In case of SAM9X60, as I specified above, there is no option to select b/w
MCK and 2xMCK as in case of, e.g. SAM9X35, but only one clock source.

> 
> 	Sam
> 
