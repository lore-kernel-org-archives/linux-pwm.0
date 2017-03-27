From: m18063 <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v3 1/2] drivers: pwm: pwm-atmel: switch to atomic PWM
Date: Mon, 27 Mar 2017 17:05:58 +0300
Message-ID: <08b1036a-bb4d-5ae2-1a68-68ccdc0b3fef@microchip.com>
References: <1490189375-20384-1-git-send-email-claudiu.beznea@microchip.com>
 <1490189375-20384-2-git-send-email-claudiu.beznea@microchip.com>
 <20170327150237.69d8523f@bbrezillon>
 <20170327131530.ifexyrgrp5egtbtr@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170327131530.ifexyrgrp5egtbtr@piout.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: mark.rutland@arm.com, linux-pwm@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tudor.ambarus@microchip.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, andrei.pistirica@microchip.com, devicetree@vger.kernel.org, thierry.reding@gmail.com, cristian.birsan@microchip.com, galak@codeaurora.org, eugen.hristev@microchip.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org


On 27.03.2017 16:15, Alexandre Belloni wrote:
> On 27/03/2017 at 15:02:37 +0200, Boris Brezillon wrote:
>> Hi Claudiu,
>>
>> On Wed, 22 Mar 2017 15:29:34 +0200
>> Claudiu Beznea <claudiu.beznea@microchip.com> wrote:
>>
>>>  static const struct platform_device_id atmel_pwm_devtypes[] = {
>>>  	{
>>>  		.name = "at91sam9rl-pwm",
>>> -		.driver_data = (kernel_ulong_t)&atmel_pwm_data_v1,
>>> +		.driver_data = (kernel_ulong_t)&atmel_pwm_regs_v1,
>>>  	}, {
>>>  		.name = "sama5d3-pwm",
>>> -		.driver_data = (kernel_ulong_t)&atmel_pwm_data_v2,
>>> +		.driver_data = (kernel_ulong_t)&atmel_pwm_regs_v2,
>>>  	}, {
>>>  		/* sentinel */
>>>  	},
>> Unrelated to this series, but can you prepare a patch to get rid of
>> this platform id table (AT91 platforms have completely switched to DT
>> for quite some time now).
>>
> Please, don't until AVR32 is gone.

Sure, I will wait for it.

>
>> You can also get rid of the "if (pdev->dev.of_node)" condition in
>> atmel_pwm_probe() since it's guaranteed to be true, otherwise the
>> ->probe() method wouldn't be called.
>>
>> Thanks,
>>
>> Boris
