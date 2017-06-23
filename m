From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] FIXUP: CHROMIUM: fix transposed param settings
Date: Fri, 23 Jun 2017 14:17:58 -0700
Message-ID: <20170623211757.GA145579@google.com>
References: <20170622175439.81256-1-nvaccaro@chromium.org>
 <20170623202313.GA122611@google.com>
 <CAME0mb0RJ81FBixF-u3Pq7+iJoLKLkqZJiFSdm25_rHCfw_Msw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33999 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbdFWVSB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Jun 2017 17:18:01 -0400
Received: by mail-pg0-f44.google.com with SMTP id e187so25806135pgc.1
        for <linux-pwm@vger.kernel.org>; Fri, 23 Jun 2017 14:18:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAME0mb0RJ81FBixF-u3Pq7+iJoLKLkqZJiFSdm25_rHCfw_Msw@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Nick Vaccaro <nvaccaro@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

(Kernel mailing lists don't usually like HTML mail. Gmail web interface
can get plain text if you really try, in one of the 'compose' options.
But it'll always screw up patch formatting, so it's only worth light
use)

On Fri, Jun 23, 2017 at 02:04:44PM -0700, Nick Vaccaro wrote:
>    Hi Brian,
>    Thanks for the info, I'm new to this process.

No problem, and understood.

>    I was asked to create a FIXUP CL and send it upstream.  Not knowing
>    format of a "FIXUP" cl, I looked at other FIXUP cl's in the chromeos
>    kernel and followed suit.

There are various reasons we might use a "FIXUP" prefix within the
Chrome OS kernel; among them: a patch might diverge upstream, as it gets
reviewed, but we might already have applied the patch to our tree.

In this case, you have a totally new patch.

[If you wanted to represent the "FIXUP" concept here, you might use a
tag like this, before the Signed-off-by:

Fixes: 1f0d3bb02785 ("pwm: Add ChromeOS EC PWM driver")
]

If in doubt, check the git log for examples (as you did already), but
note that there are different practices for mainline Linux and for the
Chromium OS, as Chromium OS is a downstream project.

>    I emailed it upstream with a "FIXUP: CHROMIUM:" prefix. Should I change
>    the checkin comment title line to "[PATCH] pwm: cros-ec: fix transposed
>    param settings" and resend the email?

Yes, that'd be all.

(And you can include my 'Reviewed-by:' tag when you resend.)

>    Please advise, thanks.

Brian
