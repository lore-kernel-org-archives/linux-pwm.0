From: Mike Dunn <mikedunn@newsguy.com>
Subject: Re: [PATCH RESEND v5 1/2] PWM: PXA: add device tree support to PWM
 driver
Date: Tue, 03 Dec 2013 10:45:29 -0800
Message-ID: <529E26C9.30707@newsguy.com>
References: <1379791174-2369-1-git-send-email-mikedunn@newsguy.com>
 <1379791174-2369-2-git-send-email-mikedunn@newsguy.com>
 <20131203101714.GG21178@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131203101714.GG21178@ulmo.nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Marek Vasut <marex@denx.de>, linux-pwm@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Chao Xie <chao.xie@marvell.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org, Ian Campbell <ian.campbell@citrix.com>
List-Id: linux-pwm@vger.kernel.org

On 12/03/2013 02:17 AM, Thierry Reding wrote:
> On Sat, Sep 21, 2013 at 12:19:33PM -0700, Mike Dunn wrote:
>> This patch adds device tree support to the PXA's PWM driver.  Nothing
>> needs to be extracted from the device tree node by the PWM device.
>> Client devices need only specify the period; the per-chip index is
>> implicitly zero because one device node must be present for each PWM
>> output in use.  This approach is more convenient due to the wide
>> variability in the number of PWM channels present across the various PXA
>> variants, and is made possible by the fact that the register sets for
>> each PWM channel are segregated from each other.  An of_xlate() method
>> is added to parse this single-cell node.  The existing ID table is
>> reused for the match table data.
>>
>> Tested on a Palm Treo 680 (both platform data and DT cases).
>>
>> Signed-off-by: Mike Dunn <mikedunn@newsguy.com>
>> ---
>>  Documentation/devicetree/bindings/pwm/pxa-pwm.txt | 30 +++++++++++++
>>  drivers/pwm/pwm-pxa.c                             | 52 ++++++++++++++++++++++-
>>  2 files changed, 81 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/pxa-pwm.txt
> 
> Hi Mike,
> 
> It looks like this fell through the cracks. Is this patch still the
> latest one you have? Should it still be applied?
> 
> Thierry
> 

Hi Thierry,

Funny I should hear from you about this today.... I just turned my attention
back to this today and noticed that it never made it into your for-next branch.
 Yes, it is the latest.  If the patch still applies cleanly, please feel free.
Otherwise, I'd be glad to rework it against something more recent.

Also, we never got any ACKs for patch 2/2, which just adds the nodes to
arch/arm/boot/dts/pxa27x.dtsi
Any advice on whom to nudge?

Thanks much!
Mike
