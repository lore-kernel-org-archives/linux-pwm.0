From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V2] pwm: tegra: Set maximum pwm clock source per SoC
 tapeout
Date: Tue, 2 May 2017 21:10:49 +0100
Message-ID: <0648240e-5e5b-9c37-909c-c551c6c32f04@nvidia.com>
References: <1493733937-15822-1-git-send-email-ldewangan@nvidia.com>
 <908ed0dc-2a75-4348-357c-191fa7348974@nvidia.com>
 <5908C555.7090204@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5908C555.7090204-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


On 02/05/17 18:43, Laxman Dewangan wrote:
> 
> On Tuesday 02 May 2017 08:53 PM, Jon Hunter wrote:
>> On 02/05/17 15:05, Laxman Dewangan wrote:
>>> The PWM hardware IP is taped-out with different maximum frequency
>>> on different SoCs.
>>>
>>>  From HW team:
>>>     Before Tegra186, it is 38.4MHz.
>>>     In Tegra186, it is 102MHz.
>>>
>>> Add support to limit the clock source frequency to the maximum IP
>>> supported frequency. Provide these values via SoC chipdata.
>>>
>>> Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>
>>> ---
>>> Changes from V1:
>>> - Set the 48MHz maximum frequency for Tegra210 and earlier.
>> I think that your changelog needs to be updated, because it still says
>> 38.4MHz and not 48MHz.
>>
> 
> Oops, thanks for pointing.
> 
> Thierry,
> Do I need to recycle the patch or can be corrected when applying?
> If there is any further review comment in code then I will recycle and
> correct it.

Feel free to add my ...

Acked-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Cheers
Jon

-- 
nvpublic
