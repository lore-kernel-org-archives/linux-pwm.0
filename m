From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 02/16] mfd: mfd-core: Don't overwrite the dma_mask of
 the child device
Date: Tue, 28 Apr 2020 15:49:49 +0100
Message-ID: <6ccad285-7b5f-3037-d4d5-ff4d9571b612@arm.com>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-3-michael@walle.cc>
 <20200428124548.GS185537@smile.fi.intel.com>
 <3cd3705a-4f48-6a46-e869-3ee11dc17323@arm.com>
 <20200428142938.GX185537@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <20200428142938.GX185537@smile.fi.intel.com>
Content-Language: en-GB
Sender: linux-hwmon-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Michael Walle <michael@walle.cc>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-pwm@vger.kernel.org

On 2020-04-28 3:29 pm, Andy Shevchenko wrote:
> On Tue, Apr 28, 2020 at 02:06:20PM +0100, Robin Murphy wrote:
>> On 2020-04-28 1:45 pm, Andy Shevchenko wrote:
>>> On Thu, Apr 23, 2020 at 07:45:29PM +0200, Michael Walle wrote:
>>>> Commit cdfee5623290 ("driver core: initialize a default DMA mask for
>>>> platform device") initialize the DMA of a platform device. But if the
>>>> parent doesn't have a dma_mask set, for example if it's an I2C device,
>>>> the dma_mask of the child platform device will be set to zero again.
>>>> Which leads to many "DMA mask not set" warnings, if the MFD cell has the
>>>> of_compatible property set.
>>>
>>> I'm wondering why parent doesn't have it.
>>
>> Because the parent isn't on a DMA-capable bus, and thus really shouldn't
>> have a valid DMA configuration ever.
> 
> Then how come a child is DMA capable?

Because it's a platform device, and thanks to decades of legacy we have 
to assume that any platform devices *is* DMA capable.

> MFD takes a physical device node as a
> parent and creates one of several children with that device as a parent. DMA
> mask is a property of the device which *does DMA*. Obviously a child is not
> correct device for that.
> 
> Where am I mistaken?

In theory you're not, however in practice the driver model doesn't 
really give us a nice way to express the necessary subtle distinctions 
between this and other similar-looking but fundamentally different 
parent-child relationships - if it did, we probably wouldn't need the 
whole MFD layer in the first place. The logical ideal would be to create 
the children on the same bus as the parent, but as it is doing that 
would likely lead to the I2C/SPI/whatever bus code assuming they are 
first-class devices and open up a whole new world of problems.

For better or worse, the platform bus is the dumping ground for random 
crap, so we just have to deal with all the abstraction breakage that 
leaks out of that.

Robin.

>>> I remember we have explicit patches in the past for buses such as PCI and AMBA
>>> to set default DMA mask for all physical devices on the respective bus, of
>>> course they can individually override it later.
>>>
>>> So, this seems to me a paper over the real issue (absence of default DMA mask
>>> where it's needed) and devices should explicitly define it if they disagree
>>> with default.
>>>
>>> If I'm wrong, you really need elaborate commit message much better.
>>
>> The problem here is that MFD children are created as platform devices
>> (regardless of what their parent is) and assigned an of_node, at which point
>> they look pretty much indistinguishable from SoC devices created by the
>> of_platform code, that *do* have to be assumed to be DMA-capable to prevent
>> ~90% of existing devicetrees from breaking.
>>
>> Of course the real fundamental issue is the platform bus itself, but it's
>> way too late to fix that :(
> 
> I don't think it's an issue, rather in model you are describing. Or I miss
> something not so obvious.
> 
