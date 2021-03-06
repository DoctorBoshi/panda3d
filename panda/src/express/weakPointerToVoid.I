/**
 * PANDA 3D SOFTWARE
 * Copyright (c) Carnegie Mellon University.  All rights reserved.
 *
 * All use of this software is subject to the terms of the revised BSD
 * license.  You should have received a copy of this license along
 * with this source code in a file named "LICENSE."
 *
 * @file weakPointerToVoid.I
 * @author drose
 * @date 2004-09-27
 */

/**
 *
 */
INLINE WeakPointerToVoid::
WeakPointerToVoid() : _weak_ref(nullptr) {
}

/**
 * Sets a callback that will be made when the pointer is deleted.  Does
 * nothing if this is a null pointer.
 *
 * If the pointer has already been deleted, the callback will be made
 * immediately.
 */
INLINE void WeakPointerToVoid::
add_callback(WeakPointerCallback *callback) const {
  if (_weak_ref != nullptr && !_weak_ref->was_deleted()) {
    _weak_ref->add_callback(callback, _void_ptr);
  } else if (_void_ptr != nullptr) {
    callback->wp_callback(_void_ptr);
    _weak_ref = nullptr;
  }
}

/**
 * Removes a previously added callback.
 */
INLINE void WeakPointerToVoid::
remove_callback(WeakPointerCallback *callback) const {
  if (_weak_ref != nullptr) {
    _weak_ref->remove_callback(callback);
  }
}

/**
 * Returns true if the object we are pointing to has been deleted, false
 * otherwise.
 */
INLINE bool WeakPointerToVoid::
was_deleted() const {
  return _void_ptr != nullptr && (_weak_ref == nullptr || _weak_ref->was_deleted());
}

/**
 * Returns true if the pointer is not null and the object has not been
 * deleted.
 */
INLINE bool WeakPointerToVoid::
is_valid_pointer() const {
  return _weak_ref != nullptr && !_weak_ref->was_deleted();
}
