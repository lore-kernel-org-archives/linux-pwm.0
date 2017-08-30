From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2] pwm_bl: Fix overflow condition
Date: Wed, 30 Aug 2017 09:26:43 -0700
Message-ID: <20170830162641.GA43114@google.com>
References: <20170829203434.6826-1-dbasehore@chromium.org>
 <20170830142741.GD1361@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170830142741.GD1361@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Derek Basehore <dbasehore@chromium.org>, linux-kernel@vger.kernel.org, jingoohan1@gmail.com, lee.jones@linaro.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Wed, Aug 30, 2017 at 04:27:41PM +0200, Thierry Reding wrote:
> I'm still confused by the brightness-levels-scale comment in the other
> thread,

I believe Derek was accidentally referring to a change that's only in
our downstream tree.

> but this looks like a good fix for a potential overflow so:

Right, it's still an applicable overflow without our downstream changes.

Brian

> Acked-by: Thierry Reding <thierry.reding@gmail.com>
