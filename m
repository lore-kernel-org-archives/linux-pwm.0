From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH 4/8] mfd: stm32-timers: add support for dmas
Date: Tue, 23 Jan 2018 16:52:49 +0100
Message-ID: <ee021839-3298-d01b-8890-619aca0399a7@st.com>
References: <1516106631-18722-1-git-send-email-fabrice.gasnier@st.com>
 <1516106631-18722-5-git-send-email-fabrice.gasnier@st.com>
 <20180123133234.xmep76cgdremnj47@dell>
 <e611b40f-bd37-aa2d-afd9-997b86d55441@st.com>
 <20180123153035.2rvhspe2m5ej57op@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180123153035.2rvhspe2m5ej57op@dell>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: mark.rutland@arm.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, devicetree@vger.kernel.org, linux@armlinux.org.uk, robh+dt@kernel.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, benjamin.gaignard@linaro.org, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: linux-pwm@vger.kernel.org

On 01/23/2018 04:30 PM, Lee Jones wrote:
> On Tue, 23 Jan 2018, Fabrice Gasnier wrote:
> 
>> On 01/23/2018 02:32 PM, Lee Jones wrote:
>>> On Tue, 16 Jan 2018, Fabrice Gasnier wrote:
>>>
>>>> STM32 Timers can support up to 7 dma requests:
>>>> 4 channels, update, compare and trigger.
>>>> Optionally request part, or all dmas from stm32-timers MFD core.
>>>> Also, keep reference of device's bus address to allow child drivers to
>>>> transfer data from/to device by using dma.
>>>>
>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>>> ---
>>>>  drivers/mfd/stm32-timers.c       | 37 ++++++++++++++++++++++++++++++++++++-
>>>>  include/linux/mfd/stm32-timers.h | 14 ++++++++++++++
>>>>  2 files changed, 50 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mfd/stm32-timers.c b/drivers/mfd/stm32-timers.c
>>>> index a6675a4..372b51e 100644
>>>> --- a/drivers/mfd/stm32-timers.c
>>>> +++ b/drivers/mfd/stm32-timers.c
>>>> @@ -29,6 +29,23 @@ static void stm32_timers_get_arr_size(struct stm32_timers *ddata)
>>>>  	regmap_write(ddata->regmap, TIM_ARR, 0x0);
>>>>  }
>>>>  
>>>> +static void stm32_timers_dma_probe(struct device *dev,
>>>> +				   struct stm32_timers *ddata)
>>>> +{
>>>> +	int i;
>>>> +	char name[4];
>>>> +
>>>> +	for (i = STM32_TIMERS_DMA_CH1; i <= STM32_TIMERS_DMA_CH4; i++) {
>>>> +		snprintf(name, ARRAY_SIZE(name), "ch%1d", i + 1);
>>>> +		ddata->dmas[i] = dma_request_slave_channel(dev, name);
>>>
>>> And if any of them fail?
>>
>> Hi Lee,
>>
>> If some of these fails, reference will be NULL. It is checked in child
>> driver (pwm for instance) at runtime. Support is being added as an
>> option: pwm capture will simply be unavailable in this case (fail with
>> error).
> 
> Can you place a simple one-line comment in here please.  Or else
> someone will come along and add error handling for you.

Hi Lee,

Ok, I'll add a comment in v2.

> 
>>>> +	}
>>>> +	ddata->dmas[STM32_TIMERS_DMA_UP] = dma_request_slave_channel(dev, "up");
>>>> +	ddata->dmas[STM32_TIMERS_DMA_TRIG] =
>>>> +		dma_request_slave_channel(dev, "trig");
>>>> +	ddata->dmas[STM32_TIMERS_DMA_COM] =
>>>> +		dma_request_slave_channel(dev, "com");
>>>
>>> Can you format these in the same why.  This hurts my eyes.
>>
>> I use enum values and try to match as possible with reference manual for
>> "up", "trig" & "com" names.
>> Would have some suggestion to beautify this?
> 
> I just mean, can you push the first  dma_request_slave_channel() call
> on to the next line, so each of the calls are formatted in the same
> manner please?

Ok, got it now. I'll do this in v2.

> 
>>>> +}
>>>> +
>>>>  static int stm32_timers_probe(struct platform_device *pdev)
>>>>  {
>>>>  	struct device *dev = &pdev->dev;
>>>> @@ -44,6 +61,7 @@ static int stm32_timers_probe(struct platform_device *pdev)
>>>>  	mmio = devm_ioremap_resource(dev, res);
>>>>  	if (IS_ERR(mmio))
>>>>  		return PTR_ERR(mmio);
>>>> +	ddata->phys_base = res->start;
>>>
>>> What do you use this for?
>>
>> This is used in in child driver (pwm) for capture data transfer by dma.
> 
> Might be worth being clear about that.
> 
> Perhaps pass in 'dma_base' (phys_base + offset) instead?
> 

I guess you've had a look at [PATCH 5/8] pwm: stm32: add capture
support. Are you talking about passing phys_base + TIM_DMAR ?

If this is the case, I'd prefer to keep phys base only if you don't
mind, and handle TIM_DMAR offset in pwm driver. This way, all dma slave
config is kept locally at one place.
Or do you mean something else ?

Maybe I can add a comment here about this ?
Something like:
/* phys_base to be used by child driver, e.g. DMA burst mode */

Please advise,
Thanks,
Fabrice
