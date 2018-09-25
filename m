From: Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [RESEND PATCH] Revert "pwm: Set class for exported channels in
 sysfs"
Date: Tue, 25 Sep 2018 15:59:26 +0200
Message-ID: <4278fef9-ec60-239a-dd0a-29a89d742fa4@st.com>
References: <1537538567-5377-1-git-send-email-fabrice.gasnier@st.com>
 <20180924115301.GV21032@ulmo> <fc02ced1-01ba-dde4-95da-285d9351338b@st.com>
 <20180924142318.GG23547@ulmo> <c4866533-1c7e-2675-5d80-3b824e32ae9b@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c4866533-1c7e-2675-5d80-3b824e32ae9b@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: stefan.wahren@i2se.com, gohai@sukzessiv.net, hsweeten@visionengravers.com, gottfried.haider@gmail.com, loic.pallardy@st.com, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, michal.vokac@ysoft.com
List-Id: linux-pwm@vger.kernel.org

On 09/24/2018 05:50 PM, Fabrice Gasnier wrote:
> On 09/24/2018 04:23 PM, Thierry Reding wrote:
>> On Mon, Sep 24, 2018 at 03:59:03PM +0200, Fabrice Gasnier wrote:
>>> On 09/24/2018 01:53 PM, Thierry Reding wrote:
>>>> On Fri, Sep 21, 2018 at 04:02:47PM +0200, Fabrice Gasnier wrote:
>>>>> This reverts commit 7e5d1fd75c3dde9fc10c4472b9368089d1b81d00 as it causes
>>>>> regression with multiple pwm chip. It creates a new entry in
>>>>> '/sys/class/pwm' every time a 'pwmX' is exported with 'echo X > export':
>>>>> - 1st time export will create an entry in /sys/class/pwm/pwmX
>>>>> - when another export happens on another pwmchip, it can't be created
>>>>> (e.g. -EEXIST)
>>>>>
>>>>> This also changes existing ABI (Documentation/ABI/testing/sysfs-class-pwm):
>>>>> - pmwX should be there: /sys/class/pwm/pwmchipN/pwmX
>>>>>
>>>>> Example on stm32 (stm32429i-eval) platform:
>>>>> $ ls /sys/class/pwm
>>>>> pwmchip0 pwmchip4
>>>>>
>>>>> $ cd /sys/class/pwm/pwmchip0/
>>>>> $ echo 0 > export
>>>>> $ ls /sys/class/pwm
>>>>> pwm0 pwmchip0 pwmchip4
>>>>>
>>>>> $ cd /sys/class/pwm/pwmchip4/
>>>>> $ echo 0 > export
>>>>> sysfs: cannot create duplicate filename '/class/pwm/pwm0'
>>>>> ...Exception stack follows...
>>>>>
>>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>>>>> ---
>>>>>  drivers/pwm/sysfs.c | 1 -
>>>>>  1 file changed, 1 deletion(-)
>>>>
>>>> Can we come up with an alternative that allows us to have both? We want
>>>> uevent and proper sysfs creation, or is that not possible?
>>>
>>> Hi Thierry, all,
>>>
>>> With current approach:
>>> - "export->child.class = parent->class"
>>> - ABI (e.g. "pwm%d") device name isn't unique with multiple pwm chip.
>>> I think this is not possible.
>>>
>>> Trying to think of an alternative... I just did a quick test, by
>>> changing device name, to take pwmchip into account:
>>> +       export->child.class = parent->class;
>>>         export->child.release = pwm_export_release;
>>>         export->child.parent = parent;
>>>         export->child.devt = MKDEV(0, 0);
>>>         export->child.groups = pwm_groups;
>>> -       dev_set_name(&export->child, "pwm%u", pwm->hwpwm);
>>> +       dev_set_name(&export->child, "pwmchip%d-pwm%u", chip->base,
>>> pwm->hwpwm);
>>>
>>> But this also impacts existing ABI :-(
>>> Would you have suggestions to send an uevent, without modifying ABI ?
>>
>> I don't quite understand why, in the example you show in the commit
>> message, the pwmX nodes appear in the top-level /sys/class/pwm
>> directory. According to Documentation/ABI/testing/sysfs-class-pwm they
>> should appear as /sys/class/pwm/pwmchipN/pwmX. I can only imagine that
>> setting the class may have changed that.
> 
> Yes, adding the class makes the link to be created under /sys/class/pwm:
> device_register() -> device_add() -> device_add_class_symlinks()
> In device_add_class_symlinks():
> ...
> 	if (!dev->class)
> 		return 0;
> ...
> 	/* link in the class directory pointing to the device */
> 	error = sysfs_create_link(&dev->class->p->subsys.kobj,
> 				  &dev->kobj, dev_name(dev));
> ...
> 
>> If so, perhaps we can
>> workaround that by creating a new class that is not parent->class?

Hi Thierry,

Maybe there's a way around, keeping the revert patch, without impacting
the ABI:
- pwmX cannot be added to pwm/another class without issue as discussed
(numbering isn't unique).
- pwmchipN already belongs to pwm class.

I did some testing, trying to send uevent on the pwmX directly, without
success: uevents are filtered as pwmX doesn't belong to a class.

Still, it is possible to send uevent (KOBJ_CHANGE) on pwmchipN device,
to notify of a change, e.g. pwmX channel being exported/unexported.

I run following prototype (with revert patch).

static int pwm_export_child(struct device *parent, struct pwm_device *pwm)
 {
+       char *pwm_prop[2];
        struct pwm_export *export;
        int ret;
 ...
                kfree(export);
                return ret;
        }
+       pwm_prop[0] = kasprintf(GFP_KERNEL, "EXPORT=pwm%u", pwm->hwpwm);
+       pwm_prop[1] = NULL;
+       kobject_uevent_env(&parent->kobj, KOBJ_CHANGE, pwm_prop);
+       kfree(pwm_prop[0]);

        return 0;
 }

 static int pwm_unexport_child(struct device *parent, struct pwm_device
*pwm)
 {
        struct device *child;
+       char *pwm_prop[2];

        if (!test_and_clear_bit(PWMF_EXPORTED, &pwm->flags))
                return -ENODEV;
...
        if (!child)
                return -ENODEV;

+       pwm_prop[0] = kasprintf(GFP_KERNEL, "UNEXPORT=pwm%u", pwm->hwpwm);
+       pwm_prop[1] = NULL;
+       kobject_uevent_env(&parent->kobj, KOBJ_CHANGE, pwm_prop);
+       kfree(pwm_prop[0]);
+
        /* for device_find_child() */

Then, I run a quick test:

# udevadm monitor --environment &
# echo 0 > /sys/class/pwm/pwmchip0/export
KERNEL[197.321736] change   /devices/.../pwm/pwmchip0 (pwm)
ACTION=change
DEVPATH=/devices/.../pwm/pwmchip0
EXPORT=pwm0
SEQNUM=2045
SUBSYSTEM=pwm

# echo 0 > /sys/class/pwm/pwmchip4/export
KERNEL[202.089676] change   /devices/.../pwm/pwmchip4 (pwm)
ACTION=change
DEVPATH=/devices/.../pwm/pwmchip4
EXPORT=pwm0
SEQNUM=2046
SUBSYSTEM=pwm


Also unexport will report change events to userland:

# echo 0 > /sys/class/pwm/pwmchip0/unexport
KERNEL[1691.112765] change   /devices/.../pwm/pwmchip0 (pwm)
ACTION=change
DEVPATH=/devices/.../pwm/pwmchip0
SEQNUM=2047
SUBSYSTEM=pwm
UNEXPORT=pwm0

Do you think this may be a way around?
Please let me know if this may satisfy need for uevents.

Best regards,
Fabrice
> 
> And this link is added using dev_name(). So I doubt adding a new class
> will change the current behavior.
> 
>>
>> Thierry
>>
