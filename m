From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] pwm: lpss: Make builtin and add lookup-table so that
 i915 can find the pwm_backlight
Date: Mon, 12 Dec 2016 12:54:09 +0100
Message-ID: <792736b5-2f95-da56-9ccf-9729b7bbc720@redhat.com>
References: <20161202101736.12236-1-hdegoede@redhat.com>
 <20161205074630.GD18069@ulmo.ba.sec>
 <bcd2a008-7dac-5084-90b5-e21634e7b57d@redhat.com>
 <20161205105943.GB19891@ulmo.ba.sec>
 <023df77a-d517-b3f0-3f37-b440db4e113e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38354 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750899AbcLLLyM (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 12 Dec 2016 06:54:12 -0500
In-Reply-To: <023df77a-d517-b3f0-3f37-b440db4e113e@redhat.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, linux-pwm@vger.kernel.org, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org

Hi,

On 05-12-16 14:23, Hans de Goede wrote:
> Hi,
>
> On 05-12-16 11:59, Thierry Reding wrote:
>> On Mon, Dec 05, 2016 at 09:18:03AM +0100, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 05-12-16 08:46, Thierry Reding wrote:
>>>> On Fri, Dec 02, 2016 at 11:17:35AM +0100, Hans de Goede wrote:
>>>>> The primary consumer of the lpss pwm is the i915 kms driver, but
>>>>> currently that driver cannot get the pwm because i915 platforms are
>>>>> not using devicetree and pwm-lpss does not call pwm_add_table.
>>>>>
>>>>> Another problem is that i915 does not support get_pwm returning
>>>>> -EPROBE_DEFER and i915's init is very complex and this is almost
>>>>> impossible to fix.
>>>>>
>>>>> This commit changes the PWM_LPSS Kconfig from a tristate to a bool, so
>>>>> that when the i915 driver loads the lpss pwm will be available avoiding
>>>>> the -EPROBE_DEFER issue. Note that this is identical to how the same
>>>>> problem was solved for the pwm-crc driver.
>>>>>
>>>>> Being builtin also allows calling pwm_add_table directly from the
>>>>> pwm-lpss code, otherwise the pwm_add_table call would need to be put
>>>>> somewhere else to ensure it happens before i915 calls pwm_get,
>>>>> even if i915 would support -EPROBE_DEFER.
>>>>>
>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>> ---
>>>>>  drivers/pwm/Kconfig    | 12 +++---------
>>>>>  drivers/pwm/pwm-lpss.c | 11 +++++++++++
>>>>>  2 files changed, 14 insertions(+), 9 deletions(-)
>>>>
>>>> This is completely backwards. You're putting board-specific bits into a
>>>> generic driver.
>>>
>>> This is not really board specific I'm advertising that the goal of
>>> the pwm is to be used to control a backlight.
>>
>> pwm_add_table() is a board-specific API. Documentation/pwm.txt says that
>> "board setup code" should be using pwm_add_table(). Using it from within
>> the provider is completely the opposite.
>
> The problem here really is that there is no such thing as
> board setup code on x86 + EFI/ACPI, that is supposedly all
> handled by the EFI/ACPI code there.
>
>>> Before typing this reply I've been thinking about another place
>>> to put the pwm_add_table call put I cannot come up with any.
>>
>> I suggested drivers/platform/x86. A bunch of code in there is doing
>> exactly the kind of board/platform setup stuff that you're trying to do
>> here.
>
> All drivers under drivers/platform/x86 bind to something, be it
> an ACPI interface or an actual platform device. In the case of the
> pwm-lpss we have an actual platform or pci device and a driver binding
> to it, that is the only common code path I see where I can add the
> pwm_add_table.
>
> Sure I can put a built-in bit of code under drivers/platform/x86
> which checks from its module_init() that there is an pwm-lpss controller
> present (either listed under ACPI or through PCI) and then calls
> pwm_add_table, but seems silly. Note as said this then must be
> built-in, because if it is a module nothing will trigger the
> loading of the module, unless I add duplicate MODULE_DEVICE_TABLE
> tables in there with the code under drivers/pwm/pwm-lpss.
>
> TL;DR: the problem is that something needs to trigger / activate
> the code doing the pwm_add_table() and AFAICT we have no other
> trigger then the presence of the pwm-lpss device, at which point
> the pwm_lpss_probe function becomes the best place to do the
> pwm_add_table call.

ping ?

Can I please get an answer to the above. I'm happy to put the
pwm_add_table call somewhere-else if that is what it takes to
get these fixes merged, but I don't see any obvious other place
to put this. So can you please tell me where to put the
pwm_add_table call, if not in pwm-lpss.c ? Note as said before
it should be triggered by the acpi-ids used to bind
the pwm-lpss driver, which to me really makes the pwm-lpss
driver the best place to do it.

Regards,

Hans
