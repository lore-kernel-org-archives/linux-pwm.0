From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [RESEND PATCH] Revert "pwm: Set class for exported channels in
 sysfs"
Date: Mon, 24 Sep 2018 15:59:03 +0200
Message-ID: <fc02ced1-01ba-dde4-95da-285d9351338b@st.com>
References: <1537538567-5377-1-git-send-email-fabrice.gasnier@st.com>
 <20180924115301.GV21032@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924115301.GV21032@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: stefan.wahren@i2se.com, gohai@sukzessiv.net, hsweeten@visionengravers.com, gottfried.haider@gmail.com, loic.pallardy@st.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On 09/24/2018 01:53 PM, Thierry Reding wrote:
> On Fri, Sep 21, 2018 at 04:02:47PM +0200, Fabrice Gasnier wrote:
>> This reverts commit 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00 as it causes
>> regression with multiple pwm chip. It creates a new entry in
>> '/sys/class/pwm' every time a 'pwmX' is exported with 'echo X > export':
>> - 1st time export will create an entry in /sys/class/pwm/pwmX
>> - when another export happens on another pwmchip, it can't be created
>> (e.g. -EEXIST)
>>
>> This also changes existing ABI (Documentation/ABI/testing/sysfs-class-pwm):
>> - pmwX should be there: /sys/class/pwm/pwmchipN/pwmX
>>
>> Example on stm32 (stm32429i-eval) platform:
>> $ ls /sys/class/pwm
>> pwmchip0 pwmchip4
>>
>> $ cd /sys/class/pwm/pwmchip0/
>> $ echo 0 > export
>> $ ls /sys/class/pwm
>> pwm0 pwmchip0 pwmchip4
>>
>> $ cd /sys/class/pwm/pwmchip4/
>> $ echo 0 > export
>> sysfs: cannot create duplicate filename '/class/pwm/pwm0'
>> ...Exception stack follows...
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>  drivers/pwm/sysfs.c | 1 -
>>  1 file changed, 1 deletion(-)
> 
> Can we come up with an alternative that allows us to have both? We want
> uevent and proper sysfs creation, or is that not possible?

Hi Thierry, all,

With current approach:
- "export->child.class = parent->class"
- ABI (e.g. "pwm%d") device name isn't unique with multiple pwm chip.
I think this is not possible.

Trying to think of an alternative... I just did a quick test, by
changing device name, to take pwmchip into account:
+       export->child.class = parent->class;
        export->child.release = pwm_export_release;
        export->child.parent = parent;
        export->child.devt = MKDEV(0, 0);
        export->child.groups = pwm_groups;
-       dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
+       dev_set_name(&export->child, "pwmchip%d-pwm%u", chip->base,
pwm->hwpwm);

But this also impacts existing ABI :-(
Would you have suggestions to send an uevent, without modifying ABI ?

Please advise,
Best regards,
Fabrice

> 
> Thierry
> 
