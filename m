From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v6 1/5] pwm: add the Berlin pwm controller driver
Date: Mon, 21 Sep 2015 23:05:06 +0200
Message-ID: <56007102.4030204@gmail.com>
References: <1442484788-15482-1-git-send-email-antoine.tenart@free-electrons.com> <1442484788-15482-2-git-send-email-antoine.tenart@free-electrons.com> <55FEF75C.4090802@gmail.com> <20150921080952.GC19865@ulmo.nvidia.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150921080952.GC19865@ulmo.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Antoine Tenart <antoine.tenart@free-electrons.com>, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 21.09.2015 10:09, Thierry Reding wrote:
> On Sun, Sep 20, 2015 at 08:13:48PM +0200, Sebastian Hesselbarth wrote:
>> On 17.09.2015 12:13, Antoine Tenart wrote:
>>> Add a PWM controller driver for the Marvell Berlin SoCs. This PWM
>>> controller has 4 channels.
>>>
>>> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
>>> Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>
>> Thierry,
>>
>> if you are also fine with the driver, please let me know if you want
>> me to take the driver through berlin-tree or if you are taking it.
>>
>> I am taking the binding docs and dts changes anyway.
>
> Sorry but no. The binding documentation needs to go into the same tree
> as the driver because they need to be kept in sync. We can't have DT
> binding documentation go into platform trees if the driver implementing
> the binding hasn't been merged.

Ok, sometimes sub-maintainers do not want to care about the DT stuff,
so I offered to take them. I am very fine with keeping binding and
driver together.

Sebastian
