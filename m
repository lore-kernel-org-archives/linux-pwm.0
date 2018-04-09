From: Mikko Perttunen <cyndis@kapsi.fi>
Subject: Re: [PATCH V2 3/9] dt-bindings: Tegra186 tachometer device tree
 bindings
Date: Mon, 9 Apr 2018 08:38:37 +0300
Message-ID: <867aace8-dac7-51d4-bd46-15919b58b37d@kapsi.fi>
References: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
 <1521607244-29734-4-git-send-email-rrajk@nvidia.com>
 <20180327145249.xjoo42qow34ksdle@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180327145249.xjoo42qow34ksdle@rob-hp-laptop>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, Rajkumar Rampelli <rrajk@nvidia.com>
Cc: mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com, jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net, catalin.marinas@arm.com, will.deacon@arm.com, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, mmaddireddy@nvidia.com, mperttunen@nvidia.com, arnd@arndb.de, timur@codeaurora.org, andy.gross@linaro.org, xuwei5@hisilicon.com, elder@linaro.org, heiko@sntech.de, krzk@kernel.org, ard.biesheuvel@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ldewangan@nvidia.com
List-Id: linux-pwm@vger.kernel.org

Rob,

this binding is for a specific IP block (for measuring/aggregating input 
pulses) on the Tegra186 SoC, so I don't think it fits into any generic 
binding.

Thanks,
Mikko

On 03/27/2018 05:52 PM, Rob Herring wrote:
> On Wed, Mar 21, 2018 at 10:10:38AM +0530, Rajkumar Rampelli wrote:
>> Supply Device tree binding documentation for the NVIDIA
>> Tegra186 SoC's Tachometer Controller
>>
>> Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
>> ---
>>
>> V2: Renamed compatible string to "nvidia,tegra186-pwm-tachometer"
>>      Renamed dt property values of clock-names and reset-names to "tachometer"
>>      from "tach"
> 
> Read my prior comments on v1.
> 
> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
