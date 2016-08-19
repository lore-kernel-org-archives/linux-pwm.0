From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 17/17] dt-bindings: pwm: sti: Update DT bindings with
 recent changes
Date: Fri, 19 Aug 2016 07:45:00 -0500
Message-ID: <CAL_JsqLOoU0gHiz7CEii3CXsGQS28u2+w5t7vxT1FStRaeObkw@mail.gmail.com>
References: <20160816093508.28307-1-lee.jones@linaro.org> <20160816093508.28307-18-lee.jones@linaro.org>
 <20160818192002.GA26225@rob-hp-laptop> <20160819083557.GK4254@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755159AbcHSMpZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 19 Aug 2016 08:45:25 -0400
In-Reply-To: <20160819083557.GK4254@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel@stlinux.com, Patrice Chotard <patrice.chotard@st.com>, Thierry Reding <thierry.reding@gmail.com>, Linux PWM List <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Fri, Aug 19, 2016 at 3:35 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 18 Aug 2016, Rob Herring wrote:
>
>> On Tue, Aug 16, 2016 at 10:35:08AM +0100, Lee Jones wrote:
>> > We're renaming the 'st,pwm-num-chan' binding to 'st,pwm-num-devs' to
>> > be more inline with the naming conventions of the subsystem.  Where
>> > we used to treat each line as a channel, the PWM convention is to
>> > describe them as devices.
>>
>> This is out of date now. Otherwise, the binding looks fine.
>
> Yes, you are right.
>
> Perhaps if this is okay with Thierry, he can remove these few lines.
> If not, I don't mind re-sending on request.
>
> I'll leave it until I hear otherwise.

Fine with me.

Acked-by: Rob Herring <robh@kernel.org>
