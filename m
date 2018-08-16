From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v1 3/7] mfd: add atmel-lcdc driver
Date: Thu, 16 Aug 2018 10:28:54 +0200
Message-ID: <1afc6d63-094b-3bff-87e9-d2354602ba76@microchip.com>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-3-sam@ravnborg.org> <20180815052435.GA6412@dell>
 <20180815204041.GA29041@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180815204041.GA29041@ravnborg.org>
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
To: Sam Ravnborg <sam@ravnborg.org>, Lee Jones <lee.jones@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pwm@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, dri-devel@lists.freedesktop.org, Boris Brezillon <boris.brezillon@bootlin.com>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 15/08/2018 at 22:40, Sam Ravnborg wrote:
> Hi Lee.
> 
>>> +
>>> +static const struct mfd_cell lcdc_cells[] = {
>>> +	{
>>> +		.name = "atmel-lcdc-pwm",
>>> +		.of_compatible = "atmel,lcdc-pwm",
>>> +	},
>>> +	{
>>> +		.name = "atmel-lcdc-dc",
>>> +		.of_compatible = "atmel,lcdc-display-controller",
>>> +	},
>>> +};
>>
>> Will you be adding any more devices, or is this the entirety of the
>> device?  If the latter, I suggest that this doesn't warrant being an
>> MFD.
> Thats it. And others agree with you that this is not a good approach.
> So in v2 there will be no MFD.
> 
> Thanks for confirming that the non-mfd way is the better approach.

MFD approach would have had the benefit of keeping this driver series 
architecture close to the HLCD one. This would have been easier to 
understand and use one SoC or another one from the AT91 product line....

Anyway, I'd wait for Boris' feedback for making a decision.

Best regards,
-- 
Nicolas Ferre
