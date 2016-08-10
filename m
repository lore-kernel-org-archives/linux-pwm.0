Return-Path: <gregkh@linuxfoundation.org>
Date: Wed, 10 Aug 2016 10:49:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] pwm: Unexport children before chip removal
Message-ID: <20160810084957.GC12080@kroah.com>
References: <1470779866-74776-1-git-send-email-davidhsu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1470779866-74776-1-git-send-email-davidhsu@google.com>
List-ID: <linux-pwm.vger.kernel.org>
To: David Hsu <davidhsu@google.com>
Cc: thierry.reding@gmail.com, sspatil@google.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Aug 09, 2016 at 02:57:46PM -0700, David Hsu wrote:
> Exported pwm channels aren't removed before the pwmchip and are
> leaked. This results in invalid sysfs files. This fix removes
> all exported pwm channels before chip removal.
> 
> Signed-off-by: David Hsu <davidhsu@google.com>
> ---
>  drivers/pwm/core.c  |  2 ++
>  drivers/pwm/sysfs.c | 18 ++++++++++++++++++
>  include/linux/pwm.h |  5 +++++
>  3 files changed, 25 insertions(+)

Should this also go to the stable kernel releases?

thanks,

greg k-h
