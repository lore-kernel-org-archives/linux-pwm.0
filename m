From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v2 0/2] pwm-tiecap: Add support for AM654 SoCs
Date: Wed, 31 Oct 2018 19:02:23 +0530
Message-ID: <e3d4afac-edc3-3b2a-3c75-8eb307705dd4@ti.com>
References: <20181016060402.18756-1-vigneshr@ti.com>
 <20181016111541.GE8852@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016111541.GE8852@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
List-Id: linux-pwm@vger.kernel.org

Hi Thierry,

On 16/10/18 4:45 PM, Thierry Reding wrote:
> On Tue, Oct 16, 2018 at 11:34:00AM +0530, Vignesh R wrote:
>> Couple of patches to enable pwm-tiecap driver to be used with TI's new
>> AM654 platforms.
>>
>> Vignesh R (2):
>>   dt-bindings: pwm: tiecap: Add TI AM654 SoC specific compatible
>>   pwm: Kconfig: Enable TI ECAP driver for ARCH_K3
>>
>>  Documentation/devicetree/bindings/pwm/pwm-tiecap.txt | 1 +
>>  drivers/pwm/Kconfig                                  | 5 ++---
>>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> Applied, thanks.
> 

I could not see this patch series in pwm tree here:
https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git
Is this queued for v4.20?

-- 
Regards
Vignesh
