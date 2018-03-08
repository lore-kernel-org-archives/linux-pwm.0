From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 05/10] hwmon: generic-pwm-tachometer: Add generic PWM
 based tachometer
Date: Thu, 8 Mar 2018 11:36:24 +0530
Message-ID: <5bffef40-a4a7-5f7d-a448-b2a381c57822@nvidia.com>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
 <1519196339-9377-6-git-send-email-rrajk@nvidia.com>
 <5172edff-fe29-7ed1-f0d2-b0359ea2c24d@roeck-us.net>
 <2510b525-ec36-b49d-5a62-81f335c0d10d@nvidia.com>
 <cfe0d0ce-3a89-bad0-85ba-6edf1135d2dc@roeck-us.net>
 <2628eff2-dd33-34f4-a7e1-cfe46ef88a3f@nvidia.com>
 <4556a8d2-947d-72c4-2962-3167afb53978@kapsi.fi>
 <62ba7f67-5a99-51ab-1214-eb68ebb7e642@roeck-us.net>
 <952cb50e-d9a0-ae5e-d9f6-d1ce268f0384@nvidia.com>
 <f7818e4c-17b6-c58b-3424-85749bb9c1cc@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <f7818e4c-17b6-c58b-3424-85749bb9c1cc@roeck-us.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Guenter Roeck <linux@roeck-us.net>, Rajkumar Rampelli <rrajk@nvidia.com>, Mikko Perttunen <cyndis@kapsi.fi>, robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com, jonathanh@nvidia.com, jdelvare@suse.com, corbet@lwn.net, catalin.marinas@arm.com, will.deacon@arm.com, kstewart@linuxfoundation.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, mmaddireddy@nvidia.com, mperttunen@nvidia.com, arnd@arndb.de, timur@codeaurora.org, andy.gross@linaro.org, xuwei5@hisilicon.com, elder@linaro.org, heiko@sntech.de, krzk@kernel.org, ard.biesheuvel@linaro.org
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org



On Wednesday 07 March 2018 07:50 PM, Guenter Roeck wrote:
> On 03/07/2018 01:47 AM, Rajkumar Rampelli wrote:
>>
>>>
>>> While I am not opposed to ABI changes, the merits of those would 
>>> need to be
>>> discussed on the mailing list. But replacing "fan1_input" with "rpm" is
>>> not an acceptable ABI change, even if it may measure something that 
>>> turns
>>> but isn't a fan.
>>>
>>> If this _is_ in fact supposed to be used for something else but 
>>> fans, we
>>> would have to discuss what that might be, and if hwmon is the 
>>> appropriate
>>> subsystem to measure and report it. This does to some degree lead 
>>> back to
>>> my concern of having the "fan" part of this patch series in the pwm 
>>> core.
>>> I am still not sure if that makes sense.
>>>
>>> Thanks,
>>> Guenter
>> I am planning to add tachometer support in pwm-fan.c driver 
>> (drivers/hwmon/) instead of adding new generic-pwm-tachometer.c 
>> driver. Measuring RPM value will be done in pwm-fan driver itself 
>> using pwm capture feature and will add new sysfs attributes under 
>> this driver to report rpm value of fan.
>
> There is an existing attribute to report the RPM of fans. It is called 
> fan[1..n]_input.
>
> "replacing "fan1_input" with "rpm" is not an acceptable ABI change"
>
> Preemptive NACK.

The RPM is measured speed via PWM signal capture  which is output from fan.
So should we have the fan[1..n]_output_rpm?
