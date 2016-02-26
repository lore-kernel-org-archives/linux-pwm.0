From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: Re: [PATCH v3 5/5] ARM: dts: DRA7: Add dt nodes for PWMSS
Date: Fri, 26 Feb 2016 13:43:14 -0600
Message-ID: <56D0AAD2.7060003@ti.com>
References: <1456439796-28546-1-git-send-email-fcooper@ti.com>
 <1456439796-28546-6-git-send-email-fcooper@ti.com>
 <20160226191848.GJ13417@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53746 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786AbcBZTnq (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Fri, 26 Feb 2016 14:43:46 -0500
In-Reply-To: <20160226191848.GJ13417@atomide.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: paul@pwsan.com, t-kristo@ti.com, vigneshr@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org

Hi Tony

On 02/26/2016 01:18 PM, Tony Lindgren wrote:
> * Franklin S Cooper Jr <fcooper@ti.com> [160225 14:37]:
>> From: Vignesh R <vigneshr@ti.com>
>>
>> Add PWMSS device tree nodes for DRA7 SoC family and add documentation
>> for dt bindings.
> 
> Are the dts changes safe to pick separately? I'm mostly worried
> about clock related hangs unless the clock changes are merged
> first.
> 
> Regards,
> 
> Tony
> 

I just did a boot test where I only had this patch applied and the dra7 board booted successfully. Of course I assume there will be problems if someone actually tried to enable EPWM or ECAP without the other clock patches.

Bootlog: http://pastebin.ubuntu.com/15208985/
