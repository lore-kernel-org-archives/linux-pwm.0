From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH v5 05/11] drm: add Atmel HLCDC Display Controller support
Date: Sat, 27 Sep 2014 23:52:44 -0400
Message-ID: <CAF6AEGsa37H8B6YpQZ2ZBNhF1kJ-TX=jbcrd1VqXCrX1ZNADFw@mail.gmail.com>
References: <1410165822-16868-1-git-send-email-boris.brezillon@free-electrons.com>
	<1410165822-16868-6-git-send-email-boris.brezillon@free-electrons.com>
	<CAF6AEGup9qvivbcovHBrf6me-sStrK_jaBTd5ofohCS9DfRV4g@mail.gmail.com>
	<20140927221255.58f4d14d@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:52950 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbaI1Dwp (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Sat, 27 Sep 2014 23:52:45 -0400
In-Reply-To: <20140927221255.58f4d14d@bbrezillon>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Boris BREZILLON <boris.brezillon@free-electrons.com>
Cc: David Airlie <airlied@linux.ie>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Andrew Victor <linux@maxim.org.za>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bo Shen <voice.shen@atmel.com>, Kumar Gala <galak@codeaurora.org>

On Sat, Sep 27, 2014 at 4:12 PM, Boris BREZILLON
<boris.brezillon@free-electrons.com> wrote:
>> > +static int atmel_hlcdc_rgb_mode_valid(struct drm_connector *connector,
>> > +                                     struct drm_display_mode *mode)
>> > +{
>> > +       return MODE_OK;
>> > +}
>>
>> your _mode_valid() should perhaps somehow check the constraints in
>> atmel_hlcdc_crtc_mode_set()?  This way invalid modes get filtered out
>> earlier..
>
> I'm not sure, the test done in atmel_hlcdc_crtc_mode_set are not
> connector related, but rather imposed by the display controller
> limitations.
> Anyway, let me know if you still think I should move those tests in the
> connector mode_valid implementation.


it gets a bit tricky if you have multiple crtc with different
constants which can be hooked to any connector (which I'm not sure if
that is the case here).. but for sure if you can eliminate modes that
cannot possibly work regardless of the crtc chosen, that is a good
thing.

So you may have to preserve the checks in the crtc.. but if you can
filter anything that is completely impossible in the connector, you
should.


BR,
-R
