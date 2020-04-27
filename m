From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v13 01/11] drm/i915: Use 64-bit division macro
Date: Mon, 27 Apr 2020 16:48:39 +0300
Message-ID: <87y2qh9gzs.fsf@intel.com>
References: <cover.1587523702.git.gurus@codeaurora.org> <4a3acf8673c08308848fb7ae73d992b6feb758d3.1587523702.git.gurus@codeaurora.org> <87ftctbe5l.fsf@intel.com> <20200424221756.GB31118@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:53448 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgD0Nsr (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 27 Apr 2020 09:48:47 -0400
In-Reply-To: <20200424221756.GB31118@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Guru Das Srinagesh <gurus@codeaurora.org>
Cc: linux-pwm@vger.kernel.org, David Collins <collinsd@codeaurora.org>, David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Subbaraman Narayanamurthy <subbaram@codeaurora.org>

On Fri, 24 Apr 2020, Guru Das Srinagesh <gurus@codeaurora.org> wrote:
> On Fri, Apr 24, 2020 at 09:17:58AM +0300, Jani Nikula wrote:
>> On Tue, 21 Apr 2020, Guru Das Srinagesh <gurus@codeaurora.org> wrote:
>> > Since the PWM framework is switching struct pwm_state.duty_cycle's
>> > datatype to u64, prepare for this transition by using DIV_ROUND_UP_ULL
>> > to handle a 64-bit dividend.
>> >
>> > To: Jani Nikula <jani.nikula@linux.intel.com>
>> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>> > Cc: David Airlie <airlied@linux.ie>
>> > Cc: Daniel Vetter <daniel@ffwll.ch>
>> > Cc: Chris Wilson <chris@chris-wilson.co.uk>
>> > Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
>> > Cc: intel-gfx@lists.freedesktop.org
>> > Cc: dri-devel@lists.freedesktop.org
>> >
>> 
>> Superfluous blank line.
>
> Will remove.
>
>> 
>> Anyway, please preserve the existing acks and reviews [1] so people
>> don't have to do it again.
>> 
>> BR,
>> Jani.
>> 
>> [1] http://lore.kernel.org/r/87h7yleb0i.fsf@intel.com
>
> I dropped your Acked-by as the patch had to changed to resolve a merge
> conflict when I rebased to tip. Could you please re-review this patch?

Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Acked-by: Jani Nikula <jani.nikula@intel.com>


-- 
Jani Nikula, Intel Open Source Graphics Center
